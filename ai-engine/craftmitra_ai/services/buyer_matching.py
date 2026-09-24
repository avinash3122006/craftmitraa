import re


class BuyerMatchingService:

    def parse_intent(
        self,
        query: str
    ):

        query_lower = query.lower()

        budget = None

        # Find ₹1000 / Rs 1000 / 1000
        matches = re.findall(
            r"(?:₹|rs\.?|inr)?\s*(\d+)",
            query_lower
        )

        if matches:

            try:
                budget = int(
                    matches[-1]
                )
            except ValueError:
                pass

        materials = []

        known_materials = [
            "bamboo",
            "wood",
            "cotton",
            "clay",
            "jute",
            "silk",
            "wool",
            "terracotta",
            "metal"
        ]

        for material in known_materials:

            if material in query_lower:
                materials.append(material)

        keywords = []

        known_keywords = [
            "handmade",
            "eco-friendly",
            "traditional",
            "gift",
            "home decor",
            "basket",
            "jewellery",
            "pottery",
            "textile"
        ]

        for keyword in known_keywords:

            if keyword in query_lower:
                keywords.append(keyword)

        return {
            "query": query,
            "budget": budget,
            "materials": materials,
            "keywords": keywords
        }

    async def match(
        self,
        query: str,
        products: list
    ):

        intent = self.parse_intent(
            query
        )

        results = []

        for product in products:

            score = 0

            text = (
                str(product.get("name", ""))
                + " "
                + str(product.get("description", ""))
                + " "
                + str(product.get("material", ""))
                + " "
                + str(product.get("tags", ""))
            ).lower()

            for keyword in intent["keywords"]:

                if keyword.lower() in text:
                    score += 2

            for material in intent["materials"]:

                if material.lower() in text:
                    score += 3

            price = product.get(
                "price",
                0
            )

            if (
                intent["budget"] is not None
                and price <= intent["budget"]
            ):
                score += 2

            if score > 0:

                results.append({
                    **product,
                    "match_score": score
                })

        results.sort(
            key=lambda x: x["match_score"],
            reverse=True
        )

        return {
            "intent": intent,
            "results": results
        }