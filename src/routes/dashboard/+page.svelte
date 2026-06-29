<script lang="ts">
  import MetricSummaryCard from '$lib/components/MetricSummaryCard.svelte';
  import LineChart from '$lib/components/LineChart.svelte';
  import InsightCard from '$lib/components/InsightCard.svelte';
  import {
    greetingHour, operationalStatus, ringkasanPenjualan, peakInfo, penjualanTrend,
    topOutlet, topPelanggan, topProdukByJumlah, topProdukByQty,
    topKategoriByJumlah, topKategoriByQty, stokRendah
  } from '$lib/mock/dashboard';

  const namaPengguna = 'Bu Siti';
  const outletAktif = 'HEKAS Pandeansari';
  const salam = greetingHour();
  const statusOperasional = operationalStatus(outletAktif);

  // Ringkasan operasional untuk banner info internal
  const totalOutlet = 4;
  const kasirAktif = 12;
  const shiftBerjalan = 3;
</script>

<svelte:head><title>Dasbor — HEKAS POS Manager</title></svelte:head>

<!-- Header halaman: judul + filter periode -->
<div class="flex items-center justify-between mb-4">
  <div>
    <h1 class="text-xl font-bold text-gray-800">Dasbor</h1>
    <p class="text-xs text-gray-500 mt-0.5">Ringkasan operasional & penjualan seluruh outlet</p>
  </div>
  <div class="flex items-center gap-2 text-xs text-gray-600">
    <i class="material-icons text-base text-gray-400">calendar_today</i>
    <span class="border border-gray-200 rounded px-3 py-1.5 bg-white">26/06/2026 - 26/06/2026</span>
  </div>
</div>

<!-- Banner info internal HEKAS (bukan promo pihak ketiga) -->
<div class="rounded overflow-hidden mb-4 bg-gradient-to-r from-[#1E3A5F] to-[#3B82F6] text-white p-5 flex items-center gap-4">
  <div class="flex-1">
    <div class="text-base font-bold leading-tight">Status Operasional Hari Ini</div>
    <div class="text-xs opacity-90 mt-1">{totalOutlet} outlet aktif · {kasirAktif} kasir on-duty · {shiftBerjalan} shift berjalan</div>
    <div class="flex gap-2 mt-3">
      <a href="/laporan" class="bg-white/20 hover:bg-white/30 text-white text-xs font-semibold px-3 py-1.5 rounded transition-colors">
        Lihat Laporan
      </a>
      <a href="/transaksi" class="bg-white text-[#1E3A5F] hover:bg-gray-100 text-xs font-semibold px-3 py-1.5 rounded transition-colors">
        Buka Transaksi
      </a>
    </div>
  </div>
  <div class="text-2xl font-extrabold tracking-tight hidden sm:block opacity-90">
    HEKAS<span class="text-xs align-top ml-1 opacity-80">POS</span>
  </div>
</div>

<!-- Salam personal -->
<div class="mb-4">
  <div class="text-base font-bold text-gray-800">{salam}, {namaPengguna} —</div>
  <div class="text-sm text-gray-600 mt-0.5">{statusOperasional}</div>
</div>

<!-- Ringkasan Penjualan -->
<div class="bg-white border border-gray-200 rounded p-5 mb-4">
  <div class="text-sm font-bold text-gray-800 mb-3">Ringkasan Penjualan</div>
  <MetricSummaryCard metrics={ringkasanPenjualan} />
</div>

<!-- Penjualan + chart -->
<div class="bg-white border border-gray-200 rounded p-5 mb-4">
  <div class="flex items-start justify-between mb-4 gap-4">
    <div class="flex-1">
      <div class="text-sm font-bold text-gray-800 mb-3">Penjualan · 7 Hari Terakhir</div>
      <div class="grid grid-cols-2 md:grid-cols-4 gap-4 text-xs">
        <div>
          <div class="text-[10px] uppercase tracking-wider text-gray-500 mb-1">Tanggal Puncak</div>
          <div class="text-sm font-bold text-gray-800">{peakInfo.tanggalPuncak}</div>
          <div class="text-gray-600 tabular-nums mt-0.5">{peakInfo.nilaiPuncak}</div>
        </div>
        <div>
          <div class="text-[10px] uppercase tracking-wider text-gray-500 mb-1">Pendapatan Tertinggi</div>
          <div class="text-sm font-bold text-gray-800">{peakInfo.tanggalTertinggi}</div>
          <div class="text-gray-600 tabular-nums mt-0.5">{peakInfo.nilaiTertinggi}</div>
        </div>
        <div>
          <div class="text-[10px] uppercase tracking-wider text-gray-500 mb-1">Tanggal Terendah</div>
          <div class="text-sm font-bold text-gray-800">{peakInfo.tanggalTerendah}</div>
          <div class="text-gray-600 tabular-nums mt-0.5">{peakInfo.nilaiTerendah}</div>
        </div>
        <div>
          <div class="text-[10px] uppercase tracking-wider text-gray-500 mb-1">Pendapatan Terendah</div>
          <div class="text-sm font-bold text-gray-800">{peakInfo.tanggalPalingRendah}</div>
          <div class="text-gray-600 tabular-nums mt-0.5">{peakInfo.nilaiPalingRendah}</div>
        </div>
      </div>
    </div>
    <select class="text-xs border border-gray-200 rounded px-3 py-1.5 bg-white focus:outline-none focus:border-[#1E3A5F] shrink-0">
      <option>Tanggal</option>
      <option>Bulan</option>
      <option>Tahun</option>
    </select>
  </div>
  <LineChart values={penjualanTrend.values} labels={penjualanTrend.labels} />
</div>

<!-- Donut cards 2-col -->
<div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
  <InsightCard title="Outlet Teratas" total="Rp 142.531.800" segments={topOutlet} />
  <InsightCard title="Pelanggan Teratas" total="Rp 142.531.800" segments={topPelanggan} />
</div>

<div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
  <InsightCard title="Produk Teratas Berdasarkan Nilai" total="Rp 142.531.800" segments={topProdukByJumlah} />
  <InsightCard title="Produk Teratas Berdasarkan Jumlah" total="7.523 unit" segments={topProdukByQty} />
</div>

<div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
  <InsightCard title="Kategori Teratas Berdasarkan Nilai" total="Rp 142.531.800" segments={topKategoriByJumlah} />
  <InsightCard title="Kategori Teratas Berdasarkan Jumlah" total="7.401 unit" segments={topKategoriByQty} />
</div>

<!-- Tabel stok rendah -->
<div class="bg-white border border-gray-200 rounded overflow-hidden mb-4">
  <div class="px-4 py-3 flex items-center justify-between border-b border-gray-200">
    <div class="text-sm font-bold text-gray-800">Produk dengan Stok Rendah</div>
    <a href="/master/produk" class="text-xs text-[#1E3A5F] hover:underline">Lihat semua</a>
  </div>
  <div class="max-h-72 overflow-y-auto">
    <table class="w-full text-sm">
      <thead class="bg-[#f3f4f6] sticky top-0">
        <tr>
          <th class="px-4 py-2.5 text-left text-xs font-medium text-gray-600">Produk</th>
          <th class="px-4 py-2.5 text-left text-xs font-medium text-gray-600">Gudang</th>
          <th class="px-4 py-2.5 text-right text-xs font-medium text-gray-600">Stok Tersedia</th>
          <th class="px-4 py-2.5 text-right text-xs font-medium text-gray-600">Stok Minimum</th>
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
</div>