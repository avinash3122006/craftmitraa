import os

import joblib
import pandas as pd

from config import settings


class PricingService:

    def __init__(self):

        self.model = None

        model_path = settings.price_model_path

        if os.path.exists(model_path):

            try:
                self.model = joblib.load(
                    model_path
                )

                print(
                    "✅ Pricing model loaded"
                )

            except Exception as e:

                print(
                    f"⚠️ Pricing model failed: {e}"
                )

    async def estimate(
        self,
        category: str,
        craft_type: str,
        material: str,
        state: str,
        size: str,
        material_qty_kg: float,
        labor_hours: float,
        material_cost_inr: float,
        labor_cost_inr: float,
        overhead_cost_inr: float
    ):

        # --------------------------------
        # MODEL NOT AVAILABLE
        # --------------------------------

        if self.model is None:

            base_cost = (
                material_cost_inr
                + labor_cost_inr
                + overhead_cost_inr
            )

            recommended = round(
                base_cost * 1.30
            )

            return {
                "estimated_price": recommended,
                "min_price": round(
                    recommended * 0.90
                ),
                "max_price": round(
                    recommended * 1.15
                ),
                "method": "cost_based_estimate"
            }

        # --------------------------------
        # XGBOOST
        # --------------------------------

        data = pd.DataFrame([
            {
                "category": category,
                "craft_type": craft_type,
                "material": material,
                "state": state,
                "size": size,
                "material_qty_kg": material_qty_kg,
                "labor_hours": labor_hours,
                "material_cost_inr": material_cost_inr,
                "labor_cost_inr": labor_cost_inr,
                "overhead_cost_inr": overhead_cost_inr
            }
        ])

        prediction = self.model.predict(data)

        price = float(prediction[0])

        return {
            "estimated_price": round(price),
            "min_price": round(price * 0.90),
            "max_price": round(price * 1.10),
            "method": "xgboost"
        }