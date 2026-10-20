import csv

film_sayisi = 0
toplam_sure = 0
uzun_film_sayisi = 0
rating_sayilari = {}

with open("filmler.csv") as f:
    okuyucu = csv.DictReader(f)
    for satir in okuyucu:
        film_sayisi += 1
        sure = int(satir["length"])
        toplam_sure += sure

        if sure > 120:
            uzun_film_sayisi += 1

        rating = satir["rating"]
        if rating in rating_sayilari:
            rating_sayilari[rating] += 1
        else:
            rating_sayilari[rating] = 1

print(f"Film sayisi: {film_sayisi}")
print(f"Ortalama sure: {toplam_sure / film_sayisi:.1f} dakika")
print(f"120 dakikadan uzun film: {uzun_film_sayisi}")

for rating, sayi in rating_sayilari.items():
    print(f"{rating}: {sayi}")