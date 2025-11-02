import pandas as pd
import tqdm
import numpy as np
import random


skateparks_dict = {
    "Ahuntsic": 8,
    "VanHorne": 4,
    "Verdun": 2,
    "Lasalle": 8.5,
    "Préfontaine": 8.5,
    "Boucherville": 7,
    "Taz": 7,
    "Spin": 6.5,
    "Saint Jérome": 8,
    "Saint Sauveur": 8.5,
    "Assomption": 8.5,
    "Benny": 8,
    "Dorval": 8,
    "Magog": 9.5,
    "Berthierville": 9.5
}


days_dict = {
    0 : "Lundi",
    1: "Mardi",
    2: "Mercredi",
    3: "Jeudi",
    4: "Vendredi",
    5: "Samedi",
    6: "Dimanche"
}

weather_dict = {
    0: "Pluie ou Neige",
    1: "Fort nuageux ou vent",
    2: "Nuageux",
    3: "Beau ciel bleu"
}

# Weather: 
# Rain or Snow  = 0
# Clouds + Wind = 1
# Clouds        = 2
# Blue sky      = 3


# Temperature: in °C
# traffic time: in minutes
# weekday 0: Monday -> 6: Sunday

N=  20
data = []

for idx in tqdm.tqdm(range(N)):
    weather = random.randint(0, 3)
    temperature = np.clip(np.random.normal(22,6), -5, 38)
    traffic_time = np.clip(np.random.normal(25, 10), 5, 150)
    weekday = random.randint(0, 6)

    print(f"\n\nJour: {days_dict[weekday]}\t météo: {weather_dict[weather]}, a {temperature}°C\t, temps de traffic: {traffic_time}min")
    for idx, (spot_name, note) in enumerate(skateparks_dict.items()):
        print(f"{spot_name} (note: {note}/10)")
        satisfaction = input(f"Satisfaction?")
        data.append({
            "spot_name": spot_name,
            "index spot": idx,
            "weather": weather_dict,
            "temperature": round(float(temperature), 1),
            "traffic_time": round(float(traffic_time), 1),
            "weekday": weekday,
            "park_score": note,
            "satisfaction": round(float(satisfaction), 2)
        })


df = pd.DataFrame(data)
print(df.head(10))

df.to_csv("data/skatepark_dataset.csv", index=False)
print("\nDone")    