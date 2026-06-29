<script lang="ts">
  type Props = {
    values: number[];
    labels?: string[];
    height?: number;
    color?: string;
  };

  let {
    values,
    labels = [],
    height = 200,
    color = '#53387d'
  }: Props = $props();

  const max = $derived(Math.max(...values, 1));
  const min = $derived(Math.min(...values, 0));
  const w = 600;
  const padding = { top: 16, right: 16, bottom: 32, left: 56 };

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
</script>

<div class="w-full">
  <svg viewBox="0 0 {w} {height}" preserveAspectRatio="none" class="w-full" style="height: {height}px;">
    <!-- Horizontal grid lines -->
    {#each gridFractions as f, i (i)}
      <line
        x1={padding.left}
        x2={w - padding.right}
        y1={padding.top + f * (height - padding.top - padding.bottom)}
        y2={padding.top + f * (height - padding.top - padding.bottom)}
        stroke="#e5e7eb"
        stroke-width="1"
        vector-effect="non-scaling-stroke"
      />
      <!-- Y-axis label -->
      <text
        x={padding.left - 8}
        y={padding.top + f * (height - padding.top - padding.bottom) + 3}
        text-anchor="end"
        font-size="9"
        fill="#9ca3af"
        font-family="Inter, sans-serif"
      >{gridValues[i].toLocaleString('id-ID', { maximumFractionDigits: 0 })}</text>
    {/each}

    <!-- Line -->
    <path d={pathLine} fill="none" stroke={color} stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" vector-effect="non-scaling-stroke" />
  </svg>

  {#if labels.length > 0}
    <div class="flex justify-between px-14 mt-1">
      {#each labels as l, i (i)}
        <div class="text-[10px] text-gray-400 flex-1 text-center">{l}</div>
      {/each}
    </div>
  {/if}
</div>