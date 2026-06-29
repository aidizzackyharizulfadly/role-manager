<script lang="ts">
  import MetricSummaryCard from '$lib/components/MetricSummaryCard.svelte';
  import LineChart from '$lib/components/LineChart.svelte';
  import InsightCard from '$lib/components/InsightCard.svelte';
  import Pagination from '$lib/components/Pagination.svelte';
  import {
    ringkasanPenjualan, peakInfo, penjualanTrend,
    topOutlet, topPelanggan, topProdukByJumlah, topProdukByQty,
    topKategoriByJumlah, topKategoriByQty, stokRendah
  } from '$lib/mock/dashboard';

  const userName = 'ENDANG';
  const greeting = 'Selamat datang';
</script>

<svelte:head><title>Dasbor — HEKAS POS Manager</title></svelte:head>

<!-- Page title row: title + period selector -->
<div class="flex items-center justify-between mb-4">
  <h1 class="text-xl font-bold text-gray-800">Dasbor</h1>
  <div class="flex items-center gap-2 text-xs text-gray-600">
    <i class="material-icons text-base text-gray-400">settings</i>
    <span class="border border-gray-200 rounded px-3 py-1.5 bg-white">26/06/2026 - 26/06/2026</span>
  </div>
</div>

<!-- Promo banner (Luna POS style purple gradient) -->
<div class="rounded overflow-hidden mb-4 bg-gradient-to-r from-[#3a1f5e] via-[#53387d] to-[#7a4fb8] text-white p-5 flex items-center gap-4">
  <div class="flex-1">
    <div class="text-base font-bold leading-tight">Inovasi terbaru dari Luna Capital.</div>
    <div class="text-xs opacity-90 mt-1">Tingkatkan transaksi bisnis, dapatkan Modal Xpress dari Luna Capital</div>
    <button class="mt-2.5 bg-yellow-400 hover:bg-yellow-500 text-gray-900 text-xs font-semibold px-4 py-1.5 rounded transition-colors">
      Dapatkan informasi lebih lanjut disini
    </button>
  </div>
  <div class="text-2xl font-extrabold tracking-tight hidden sm:block">
    LUNA<span class="text-xs align-top ml-1 opacity-80">Capital</span>
  </div>
</div>

<!-- Greeting -->
<div class="text-base font-bold text-gray-800 mb-3">{greeting} <span class="text-[#53387d]">{userName}</span></div>

<!-- Ringkasan Penjualan card -->
<div class="bg-white border border-gray-200 rounded p-5 mb-4">
  <div class="text-sm font-bold text-gray-800 mb-3">Ringkasan Penjualan</div>
  <MetricSummaryCard metrics={ringkasanPenjualan} />
</div>

<!-- Penjualan line chart card -->
<div class="bg-white border border-gray-200 rounded p-5 mb-4">
  <div class="flex items-start justify-between mb-4">
    <div>
      <div class="text-sm font-bold text-gray-800 mb-3">Penjualan</div>
      <div class="grid grid-cols-4 gap-6 text-xs">
        <div>
          <div class="text-[10px] uppercase tracking-wider text-gray-500 mb-1">Peak Date</div>
          <div class="text-sm font-bold text-gray-800">{peakInfo.peakDate}</div>
        </div>
        <div>
          <div class="text-[10px] uppercase tracking-wider text-gray-500 mb-1">Top Income</div>
          <div class="text-sm font-bold text-gray-800 tabular-nums">{peakInfo.topIncome}</div>
        </div>
        <div>
          <div class="text-[10px] uppercase tracking-wider text-gray-500 mb-1">Low Date</div>
          <div class="text-sm font-bold text-gray-800">{peakInfo.lowDate}</div>
        </div>
        <div>
          <div class="text-[10px] uppercase tracking-wider text-gray-500 mb-1">Lower Income</div>
          <div class="text-sm font-bold text-gray-800 tabular-nums">{peakInfo.lowerDate}</div>
        </div>
      </div>
    </div>
    <select class="text-xs border border-gray-200 rounded px-3 py-1.5 bg-white focus:outline-none focus:border-[#53387d]">
      <option>Tanggal</option>
      <option>Bulan</option>
      <option>Tahun</option>
    </select>
  </div>
  <LineChart values={penjualanTrend.values} labels={penjualanTrend.labels} />
</div>

<!-- 2-col donut cards -->
<div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
  <InsightCard title="Top Outlet" total="Rp 4.388.100,00" segments={topOutlet} />
  <InsightCard title="Top Pelanggan" total="Rp 4.388.100,00" segments={topPelanggan} />
</div>

<div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
  <InsightCard title="Top Produk Berdasarkan Jumlah" total="Rp 4.388.100,00" segments={topProdukByJumlah} />
  <InsightCard title="Top Produk Berdasarkan Qty" total="740" segments={topProdukByQty} />
</div>

<div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
  <InsightCard title="Top Kategori Produk Berdasarkan Jumlah" total="Rp 4.388.100,00" segments={topKategoriByJumlah} />
  <InsightCard title="Top Kategori Produk Berdasarkan Qty" total="740" segments={topKategoriByQty} />
</div>

<!-- Stok Rendah table card -->
<div class="bg-white border border-gray-200 rounded overflow-hidden mb-4">
  <div class="px-4 py-3 flex items-center justify-between border-b border-gray-200">
    <div class="text-sm font-bold text-gray-800">Produk dengan Stok Rendah</div>
    <button class="text-xs text-gray-500 hover:text-[#53387d]">Lainnya</button>
  </div>
  <div class="max-h-72 overflow-y-auto">
    <table class="w-full text-sm">
      <thead class="bg-[#f3f4f6] sticky top-0">
        <tr>
          <th class="px-4 py-2.5 text-left text-xs font-medium text-gray-600">Produk</th>
          <th class="px-4 py-2.5 text-left text-xs font-medium text-gray-600">Gudang</th>
          <th class="px-4 py-2.5 text-right text-xs font-medium text-gray-600">Qty Tersedia</th>
          <th class="px-4 py-2.5 text-right text-xs font-medium text-gray-600">Minimum Qty</th>
        </tr>
      </thead>
      <tbody>
        {#each stokRendah as row, i (i)}
          <tr class="border-b border-gray-100 hover:bg-gray-50">
            <td class="px-4 py-2.5 text-gray-800">{row.produk}</td>
            <td class="px-4 py-2.5 text-gray-700">{row.gudang}</td>
            <td class="px-4 py-2.5 text-right tabular-nums text-rose-600 font-semibold">{row.qty}</td>
            <td class="px-4 py-2.5 text-right tabular-nums text-gray-700">{row.minimum}</td>
          </tr>
        {/each}
      </tbody>
    </table>
  </div>
  <div class="px-4 py-3 flex items-center justify-end border-t border-gray-200">
    <button class="bg-[#53387d] hover:bg-[#3f2a5f] text-white text-xs px-3 py-1.5 rounded transition-colors">Lainnya</button>
  </div>
</div>