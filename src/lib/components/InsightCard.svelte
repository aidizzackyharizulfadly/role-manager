<script lang="ts">
  import DonutChart from './DonutChart.svelte';

  type Segment = {
    label: string;
    value: number;
    color: string;
    raw?: string;
    pct?: string;
  };

  type Props = {
    title: string;
    total: string;
    segments: Segment[];
    moreLabel?: string;
  };

  let { title, total, segments, moreLabel = 'Selengkapnya' }: Props = $props();
</script>

<!--
  Style: card putih border tipis rounded, title bold, angka TOTAL medium-grey
  di atas donut, legend dengan bar vertikal + value/label/percent stacked,
  tombol Selengkapnya bg navy #1E3A5F.
-->
<div class="bg-white border border-gray-200 rounded p-5 flex flex-col">
  <div class="text-sm font-bold text-gray-800 mb-3">{title}</div>

  <div class="flex items-baseline gap-1.5 mb-3">
    <div class="text-lg font-bold text-gray-500 tabular-nums">{total}</div>
    <div class="text-[10px] uppercase tracking-wider text-gray-400">Total</div>
  </div>

  <div class="flex items-start gap-6">
    <div class="shrink-0">
      <DonutChart {segments} size={140} thickness={18} />
    </div>
    <div class="flex-1 min-w-0 space-y-2.5">
      {#each segments as s, i (i)}
        <div class="flex items-start gap-2 text-xs">
          <span class="w-1 self-stretch min-h-[28px] rounded-sm shrink-0" style="background: {s.color};"></span>
          <div class="flex-1 min-w-0">
            <div class="font-bold text-gray-800 tabular-nums leading-tight">{s.raw ?? s.value.toLocaleString('id-ID')}</div>
            <div class="text-gray-600 truncate mt-0.5">{s.label}</div>
            {#if s.pct}
              <div class="text-[10px] text-gray-400 mt-0.5">{s.pct}</div>
            {/if}
          </div>
        </div>
      {/each}
    </div>
  </div>

  <div class="flex justify-end mt-4">
    <button class="bg-[#1E3A5F] hover:bg-[#15294a] text-white text-xs px-3 py-1.5 rounded transition-colors">
      {moreLabel}
    </button>
  </div>
</div>