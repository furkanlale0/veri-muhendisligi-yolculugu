import pandas as pd
df = pd.read_csv("filmler.csv") 
print(df.head())

print(f"Film sayisi: {len(df)}")

print(f"Ortalama sure: {df["length"].mean():.1f}")

print(f"120 dakikadan uzun: {len(df[df['length'] > 120])}")

print("her ratingden kac film var: ")

print(df['rating'].value_counts())
