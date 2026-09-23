# sokuja-api

REST API JSON untuk [SOKUJA](https://x6.sokuja.uk/) (anime subtitle Indonesia).
Data diambil langsung dari situs saat diminta, lalu di-cache 5 menit. Tidak ada
database dan tidak ada dependency — cukup Python 3.11.

```bash
python3 sokuja_api.py 8787
```

## Endpoint

| Method | Path | Isi |
|---|---|---|
| GET | `/` | daftar endpoint |
| GET | `/api/latest?page=1` | episode terbaru, 18 per halaman |
| GET | `/api/search?q=one+piece&limit=10` | cari anime (maks 30) |
| GET | `/api/anime/{slug}` | detail anime, sinopsis, genre, seluruh episode, batch download |
| GET | `/api/episode/{slug}` | episode: stream per kualitas, link download, episode sebelum/sesudah |
| GET | `/api/schedule` | jadwal rilis per hari (WIB) |
| GET | `/api/genres` | 88 genre beserta jumlah anime |
| GET | `/api/genre/{slug}?page=1` | anime dalam satu genre |
| GET | `/api/browse?status=ongoing&type=TV&order=update` | telusuri katalog |

`slug` anime berbentuk `one-piece-subtitle-indonesia`, slug episode berbentuk
`one-piece-episode-1179-subtitle-indonesia`. Keduanya ada di field `slug` semua
respons, jadi bisa dirangkai dari `/api/search` atau `/api/latest`.

## Contoh

```bash
curl 'http://127.0.0.1:8787/api/search?q=one%20piece&limit=3'
curl 'http://127.0.0.1:8787/api/anime/one-piece-subtitle-indonesia'
curl 'http://127.0.0.1:8787/api/episode/one-piece-episode-1179-subtitle-indonesia'
```

## Catatan

- `stream[].url` adalah file MP4 langsung per kualitas (480p/720p/1080p).
- `downloads[].url` adalah tautan keluar `sokuja.id/x.php` milik situs, sama
  seperti tombol download di halaman aslinya.
- Link batch (mis. `https://global.nontony.uk/...rar`) ada di
  `episodes[].downloads` pada anime yang menyediakan batch.
- Semua URL gambar sudah dijadikan absolut.
- Respons error: `404` untuk slug yang tidak ada, `400` untuk parameter yang
  kurang, `502` kalau situs sumber bermasalah.
