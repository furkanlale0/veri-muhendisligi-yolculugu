notlar = {
    "Sistem proglrmalama": 85,
    "Yazilim Tasarimi": 78,
    "Kriptoloji": 92,
}

notlar["Sayisal Cozumleme"] = 65

toplam = 0
for ders, puan in notlar.items():
    print(ders, " - ", puan)
    toplam = toplam + puan

ortalama = toplam/len(notlar)
print("Ortalama : ", ortalama) 

if ortalama > 70:
    print("Gecti")
else:
    print("Kaldi")

print(max(notlar.values()))
