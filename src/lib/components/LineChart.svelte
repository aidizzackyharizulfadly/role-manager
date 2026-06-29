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
    height = 360,
    color = '#1E3A5F',
    axisColor = '#6b7280'
  }: Props = $props();

  const max = $derived(Math.max(...values, 1));
  const min = $derived(Math.min(...values, 0));
  const w = 600;
  const padding = { top: 24, right: 28, bottom: 56, left: 68 };

  function x(i: number): number {
    return padding.left + (i * (w - padding.left - padding.right)) / Math.max(values.length - 1, 1);
  }

  function y(v: number): number {
    if (max === min) return height / 2;
    return height - padding.bottom - ((v - min) / (max - min)) * (height - padding.top - padding.bottom);
  }

  const pathLine = $derived(values.map((v, i) => `${i === 0 ? 'M' : 'L'} ${x(i).toFixed(2)} ${y(v).toFixed(2)}`).join(' '));

  // 5 gridlines horizontal (sumbu Y), value range dibulatkan supaya labelnya rapi
  const yTickCount = 5;
  const yRange = $derived(max - min || 1);
  const yStep = $derived(yRange / (yTickCount - 1));
  const yTicks = $derived(Array.from({ length: yTickCount }, (_, i) => min + i * yStep));

  // Format angka ringkas: 15000000 -> "15jt", 5000000 -> "5jt", 50000 -> "50rb"
  function formatShort(v: number): string {
    const abs = Math.abs(v);
    if (abs >= 1_000_000_000) return (v / 1_000_000_000).toFixed(1).replace(/\.0$/, '') + 'M';
    if (abs >= 1_000_000) return (v / 1_000_000).toFixed(1).replace(/\.0$/, '') + 'jt';
    if (abs >= 1_000) return (v / 1_000).toFixed(0) + 'rb';
    return v.toFixed(0);
  }

  // Posisi X untuk tiap label hari (relatif terhadap viewBox, presisi saat di-scale)
  const labelPositions = $derived(values.map((_, i) => x(i)));

  // Peak index untuk highlight
  const peakIdx = $derived(values.indexOf(Math.max(...values)));
</script>

<div class="w-full">
  <svg viewBox="0 0 {w} {height}" preserveAspectRatio="none" class="w-full block" style="height: {height}px;">
    <!-- Background area chart (subtle) -->
    <rect
      x={padding.left}
      y={padding.top}
      width={w - padding.left - padding.right}
      height={height - padding.top - padding.bottom}
      fill="#fafbfc"
      rx="2"
    />

    <!-- Vertical dashed gridlines: pembatas per hari (antara titik data, subtle) -->
    {#each values.slice(1) as _, idx (idx)}
      {@const xv = (x(idx) + x(idx + 1)) / 2}
      <line
        x1={xv}
        x2={xv}
        y1={padding.top}
        y2={height - padding.bottom}
        stroke="#e5e7eb"
        stroke-width="1"
        stroke-dasharray="2 4"
        opacity="0.7"
        vector-effect="non-scaling-stroke"
      />
    {/each}

    <!-- Horizontal gridlines + label sumbu Y (subtle interior, baseline tegas) -->
    {#each yTicks as v, i (i)}
      {@const yy = height - padding.bottom - (i / (yTickCount - 1)) * (height - padding.top - padding.bottom)}
      {@const isBaseline = i === 0}
      <line
        x1={padding.left}
        x2={w - padding.right}
        y1={yy}
        y2={yy}
        stroke={isBaseline ? axisColor : '#e5e7eb'}
        stroke-width={isBaseline ? '1.2' : '1'}
        stroke-dasharray={isBaseline ? '' : '2 4'}
        opacity={isBaseline ? 1 : 0.6}
        vector-effect="non-scaling-stroke"
      />
      <text
        x={padding.left - 10}
        y={yy + 3.5}
        text-anchor="end"
        font-size="10"
        font-weight="500"
        fill={isBaseline ? axisColor : '#9ca3af'}
        font-family="Inter, sans-serif"
      >{formatShort(v)}</text>
    {/each}

    <!-- Sumbu Y (kiri, tegas) -->
    <line
      x1={padding.left}
      x2={padding.left}
      y1={padding.top}
      y2={height - padding.bottom}
      stroke={axisColor}
      stroke-width="1.2"
      vector-effect="non-scaling-stroke"
    />

    <!-- Tick marks di sumbu X untuk tiap hari (boundary tegas) -->
    {#each values as _, i (i)}
      <line
        x1={x(i)}
        x2={x(i)}
        y1={height - padding.bottom}
        y2={height - padding.bottom + 6}
        stroke={axisColor}
        stroke-width="1.2"
        vector-effect="non-scaling-stroke"
      />
    {/each}

    <!-- Label hari di sumbu X (presisi mengikuti titik data, tegas) -->
    {#each labels as l, i (i)}
      <text
        x={labelPositions[i]}
        y={height - padding.bottom + 26}
        text-anchor="middle"
        font-size="13"
        font-weight="700"
        letter-spacing="0.3"
        fill={i === peakIdx ? '#1E3A5F' : '#374151'}
        font-family="Inter, sans-serif"
      >{l}</text>
    {/each}

    <!-- Garis utama (navy, tegas 2px) -->
    <path
      d={pathLine}
      fill="none"
      stroke={color}
      stroke-width="2"
      stroke-linecap="round"
      stroke-linejoin="round"
      vector-effect="non-scaling-stroke"
    />

    <!-- Titik data: filled circle di setiap hari, peak lebih besar -->
    {#each values as v, i (i)}
      {@const isPeak = i === peakIdx}
      <circle
        cx={x(i)}
        cy={y(v)}
        r={isPeak ? 5 : 3.5}
        fill={isPeak ? '#f59e0b' : 'white'}
        stroke={isPeak ? '#d97706' : color}
        stroke-width={isPeak ? 2 : 1.8}
        vector-effect="non-scaling-stroke"
      />
    {/each}
  </svg>
</div>