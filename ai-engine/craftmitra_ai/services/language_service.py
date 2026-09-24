import re


class LanguageService:

    def detect(self, text: str) -> str:

        if not text:
            return "unknown"

        # Tamil Unicode
        if re.search(r"[\u0B80-\u0BFF]", text):
            return "ta"

        # Hindi / Devanagari
        if re.search(r"[\u0900-\u097F]", text):
            return "hi"

        # Telugu
        if re.search(r"[\u0C00-\u0C7F]", text):
            return "te"

        # Kannada
        if re.search(r"[\u0C80-\u0CFF]", text):
            return "kn"

        # Malayalam
        if re.search(r"[\u0D00-\u0D7F]", text):
            return "ml"

        return "en"