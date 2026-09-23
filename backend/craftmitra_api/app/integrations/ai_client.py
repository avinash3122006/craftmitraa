class AIClient:
    """Mock AI Client simulating multimodal craft analysis, speech-to-text,

    story generation, and fair-pricing algorithms without paid API tokens.
    """

    def __init__(self):
        self.mock_mode = True

    def speech_to_text(self, audio_data: str | None = None, language: str = 'Hindi') -> dict:
        transcripts = {
            'Hindi': 'Yeh Banas nadi ki mitti se bana haath ka sacred hathi relief plaque hai. Do din lag gaye sukhane aur natural geru lagane me. Isme 16 ghante ka haath ka kaam hai.',
            'Rajasthani': 'Molela ri mitti ro banyo haath so kadiyo Surya dev plaque hai. Banas nadi ri chikni mitti lagai.',
            'English': 'This is a hand-molded terracotta sacred elephant votive plaque made using authentic Banas river clay and natural mineral pigments.',
        }
        transcript = transcripts.get(language, transcripts['Hindi'])
        return {
            'transcript': transcript,
            'language': language,
            'confidence': 0.96,
        }

    def analyze_product_multimodal(
        self,
        image_url: str | None = None,
        voice_text: str | None = None,
        language: str = 'Hindi',
    ) -> dict:
        text = voice_text or ''
        is_silk = 'silk' in text.lower() or 'saree' in text.lower() or 'zari' in text.lower()
        is_brass = 'brass' in text.lower() or 'dhokra' in text.lower() or 'metal' in text.lower()

        if is_silk:
            return {
                'suggested_title': 'Chanderi Pure Silk Handloom Zari Saree',
                'category': 'Handloom',
                'generated_description': 'Hand-woven feather-light Chanderi silk saree with tested gold zari bootis crafted on traditional wooden pit looms.',
                'cultural_story': 'Preserving 700 years of Scindia royal patronage in Pranpur village. Takes 18 days of patient rhythmic loom passing to weave one masterpiece.',
                'detected_materials': ['Mulberry Silk', 'Tested Gold Zari', 'Fine Cotton Warp'],
                'suggested_fair_price_min': 7200.0,
                'suggested_fair_price_max': 8500.0,
                'recommended_price': 7800.0,
                'estimated_labor_hours': 64,
                'suggested_tags': ['Handloom', 'Chanderi', 'Silk', 'Pit Loom', 'GI Tagged'],
                'confidence_score': 0.95,
                'sustainability_rating': '100% Handwoven Natural Silk',
            }

        if is_brass:
            return {
                'suggested_title': 'Bastar Dhokra Lost-Wax Horn Musician',
                'category': 'Brass & Metal',
                'generated_description': 'Single-cast hollow bell metal figurine crafted using the rare 4,000-year-old Harappan lost-wax casting technique.',
                'cultural_story': 'Every piece is entirely unique as the riverbed clay core is broken to extract the solid bronze figure. Passed down through Bastar tribal lineages.',
                'detected_materials': ['Recycled Brass', 'Natural Beeswax', 'Termite Hill Clay'],
                'suggested_fair_price_min': 2600.0,
                'suggested_fair_price_max': 3400.0,
                'recommended_price': 2900.0,
                'estimated_labor_hours': 36,
                'suggested_tags': ['Dhokra', 'Tribal Art', 'Lost Wax', 'Brass Figurine', 'GI Certified'],
                'confidence_score': 0.94,
                'sustainability_rating': 'Recycled Scrap Metal & Beeswax',
            }

        # Default Terracotta Craft
        return {
            'suggested_title': 'Molela Sacred Terracotta Elephant Votive Plaque',
            'category': 'Terracotta',
            'generated_description': 'Authentic hollow-relief votive plaque hand-sculpted using fertile riverbed silt from Banas riverbank. Decorated with organic mineral ochre.',
            'cultural_story': 'Molela hollow votive plaques have been crafted for over 300 years by the Kumhar community for shrines in southern Rajasthan. Hand-pinched with thumb and wooden knife without molds.',
            'detected_materials': ['Banas River Clay', 'Organic Ghori Gum Resin', 'Natural Red Ochre (Geru)'],
            'suggested_fair_price_min': 1850.0,
            'suggested_fair_price_max': 2400.0,
            'recommended_price': 2150.0,
            'estimated_labor_hours': 16,
            'suggested_tags': ['Terracotta', 'Molela', 'Sacred Plaque', 'Handmade Clay', 'GI Craft', 'Eco Living'],
            'confidence_score': 0.96,
            'sustainability_rating': '100% Biodegradable & Chemical-free',
        }
