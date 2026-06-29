<script lang="ts">
  type Props = {
    label: string;
    value: string;
    sublabel?: string;
  };

  let { label, value, sublabel }: Props = $props();
</script>

<!-- Luna POS style: bg abu muda #f3f4f6, value bold medium di atas, label uppercase tracking abu di bawah -->
<div class="bg-[#f3f4f6] rounded px-4 py-3 text-center">
  <div class="text-base font-bold text-gray-800 tabular-nums leading-tight">{value}</div>
  <div class="text-[10px] uppercase tracking-wider text-gray-500 mt-1.5">{label}</div>
  {#if sublabel}
    <div class="text-[10px] text-gray-400 mt-0.5">{sublabel}</div>
  {/if}
</div>