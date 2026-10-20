def harf_notu(puan):
    if puan >= 90:
        return "AA"
    elif puan >= 80:
        return "BA"
    elif puan >= 70:
        return "BB"
    elif puan >= 60:
        return "CB"
    else:
        return "KALDİN KRAL"
notlar = {
    "Sistem proglrmalama": 85,
    "Yazilim Tasarimi": 78,
    "Kriptoloji": 92,
}

notlar["Sayisal Cozumleme"] = 65

toplam = 0
for ders, puan in notlar.items():
    print(ders, " - ", puan, harf_notu(puan))
    toplam = toplam + puan