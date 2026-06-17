import sys

print("arguments", sys.argv)

month = int(sys.argv[1])
print(f"hello {sys.argv[0]} month: {month}")


import pandas as pd
df = pd.DataFrame({"A": [1, 2,3], "B": [3, 4,0]})
print(df.head())

df.to_parquet(f"output_say_{sys.argv[1]}.parquet")