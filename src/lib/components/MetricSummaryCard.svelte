<script lang="ts">
  type Metric = { label: string; value: string; trend?: string; accent?: string };

  type Props = { metrics: Metric[] };
  let { metrics }: Props = $props();
</script>

<!--
  Luna POS style: 4-col grid, tiap cell bg abu muda #f3f4f6,
  value bold medium di tengah, label uppercase tracking abu di bawah.
-->
<div class="grid grid-cols-2 md:grid-cols-4 gap-3">
  {#each metrics as m, i (i)}
    <div class="bg-[#f3f4f6] rounded px-4 py-3 text-center">
      <div class="text-base font-bold text-gray-800 tabular-nums leading-tight">{m.value}</div>
      <div class="text-[10px] uppercase tracking-wider text-gray-500 mt-1.5">{m.label}</div>
    </div>
  {/each}
</div>