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
  Luna POS style: card border tipis, title bold atas-kiri, TOTAL number
  besar medium-grey di atas donut. Donut ungu tebal di kiri, legend
  list di kanan dengan value bold + label + percent. Selengkapnya button
  bottom-right bg ungu #53387d.
-->
<div class="bg-white border border-gray-200 rounded p-5 flex flex-col">
  <div class="text-sm font-bold text-gray-800 mb-3">{title}</div>

  <div class="flex items-baseline gap-1 mb-1">
    <div class="text-lg font-bold text-gray-500 tabular-nums">{total}</div>
    <div class="text-[10px] uppercase tracking-wider text-gray-400">Total</div>
  </div>

  <div class="flex items-start gap-6 mt-2">
    <div class="shrink-0">
      <DonutChart {segments} size={140} thickness={18} />
    </div>
    <div class="flex-1 min-w-0 space-y-2.5 mt-1">
      {#each segments as s, i (i)}
        <div class="flex items-start gap-2 text-xs">
          <span class="w-1 h-full min-h-[28px] rounded-sm shrink-0" style="background: {s.color};"></span>
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
    <button class="bg-[#53387d] hover:bg-[#3f2a5f] text-white text-xs px-3 py-1.5 rounded transition-colors">
      {moreLabel}
    </button>
  </div>
</div>