<script lang="ts">
  type Props = {
    values: number[];
    labels?: string[];
    height?: number;
    color?: string;
    axisColor?: string;
  };

  let {
    values,
    labels = [],
    height = 220,
    color = '#1E3A5F',
    axisColor = '#9ca3af'
  }: Props = $props();

  const max = $derived(Math.max(...values, 1));
  const min = $derived(Math.min(...values, 0));
  const w = 600;
  const padding = { top: 16, right: 16, bottom: 32, left: 60 };

  function x(i: number): number {
    return padding.left + (i * (w - padding.left - padding.right)) / Math.max(values.length - 1, 1);
  }

  function y(v: number): number {
    if (max === min) return height / 2;
    return height - padding.bottom - ((v - min) / (max - min)) * (height - padding.top - padding.bottom);
  }

  const pathLine = $derived(values.map((v, i) => `${i === 0 ? 'M' : 'L'} ${x(i).toFixed(2)} ${y(v).toFixed(2)}`).join(' '));

  // 5 grid lines (0, 0.25, 0.5, 0.75, 1)
  const gridFractions = [0, 0.25, 0.5, 0.75, 1];
  const gridValues = $derived(gridFractions.map(f => min + (max - min) * (1 - f)));

  // Format angka ringkas: 15000000 -> "15jt", 5000000 -> "5jt", 50000 -> "50rb"
  function formatShort(v: number): string {
    const abs = Math.abs(v);
    if (abs >= 1_000_000_000) return (v / 1_000_000_000).toFixed(abs >= 10_000_000_000 ? 0 : 1).replace(/\.0$/, '') + 'M';
    if (abs >= 1_000_000) return (v / 1_000_000).toFixed(abs >= 10_000_000 ? 0 : 1).replace(/\.0$/, '') + 'jt';
    if (abs >= 1_000) return (v / 1_000).toFixed(0) + 'rb';
    return v.toString();
  }

  // Posisi X untuk tiap label hari (relatif terhadap viewBox, jadi tetap presisi saat di-scale)
  const labelPositions = $derived(values.map((_, i) => x(i)));
</script>

<div class="w-full">
  <svg viewBox="0 0 {w} {height}" preserveAspectRatio="none" class="w-full block" style="height: {height}px;">
    <!-- Vertical gridlines: pembatas per hari (di antara titik data) -->
    {#each values.slice(1, -1) as _, idx (idx)}
      {@const xv = (x(idx) + x(idx + 1)) / 2}
      <line
        x1={xv}
        x2={xv}
        y1={padding.top}
        y2={height - padding.bottom}
        stroke="#e5e7eb"
        stroke-width="1"
        stroke-dasharray="3 3"
        vector-effect="non-scaling-stroke"
      />
    {/each}

    <!-- Horizontal gridlines + label sumbu Y -->
    {#each gridFractions as f, i (i)}
      <line
        x1={padding.left}
        x2={w - padding.right}
        y1={padding.top + f * (height - padding.top - padding.bottom)}
        y2={padding.top + f * (height - padding.top - padding.bottom)}
        stroke={f === 0 ? axisColor : '#e5e7eb'}
        stroke-width={f === 0 ? '1' : '1'}
        stroke-dasharray={f === 0 ? '' : '3 3'}
        vector-effect="non-scaling-stroke"
      />
      <text
        x={padding.left - 8}
        y={padding.top + f * (height - padding.top - padding.bottom) + 3}
        text-anchor="end"
        font-size="9"
        fill="#9ca3af"
        font-family="Inter, sans-serif"
      >{formatShort(gridValues[i])}</text>
    {/each}

    <!-- Sumbu Y (kiri, tegas) -->
    <line
      x1={padding.left}
      x2={padding.left}
      y1={padding.top}
      y2={height - padding.bottom}
      stroke={axisColor}
      stroke-width="1"
      vector-effect="non-scaling-stroke"
    />

    <!-- Tick marks di sumbu X untuk tiap hari -->
    {#each values as _, i (i)}
      <line
        x1={x(i)}
        x2={x(i)}
        y1={height - padding.bottom}
        y2={height - padding.bottom + 4}
        stroke={axisColor}
        stroke-width="1"
        vector-effect="non-scaling-stroke"
      />
    {/each}

    <!-- Label hari di sumbu X (presisi mengikuti titik data) -->
    {#each labels as l, i (i)}
      <text
        x={labelPositions[i]}
        y={height - padding.bottom + 16}
        text-anchor="middle"
        font-size="9"
        fill="#6b7280"
        font-family="Inter, sans-serif"
      >{l}</text>
    {/each}

    <!-- Garis utama -->
    <path d={pathLine} fill="none" stroke={color} stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" vector-effect="non-scaling-stroke" />

    <!-- Titik data: bulat solid di setiap hari -->
    {#each values as v, i (i)}
      <circle
        cx={x(i)}
        cy={y(v)}
        r="3"
        fill="white"
        stroke={color}
        stroke-width="1.5"
        vector-effect="non-scaling-stroke"
      />
    {/each}
  </svg>
</div>