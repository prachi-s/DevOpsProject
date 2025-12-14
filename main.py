from typing import Union
from datetime import datetime
from fastapi import FastAPI, Request

app = FastAPI()


@app.get("/")
def root(request:Request):
    print(request.body)
    return {
        "timestamp": datetime.now(),
        "ip": request.client.host
        }
