import pandas as pd
from fastapi import FastAPI

app = FastAPI()

@app.get("/random-numbers")
def random_numbers(n: int = 10):
    """Generate a dataframe with `n` random numbers."""
    df = pd.DataFrame(pd.np.random.randint(0, 100, size=(n, 2)))
    return df
