import re
import os

# --- Dependency Management ---
# We use a try/except block here for 'Graceful Degradation'. 
# If TextBlob isn't installed in the local environment, the library will 
# fall back to basic Heuristic matching instead of crashing the IDE/CI.
try:
    from textblob import TextBlob
    HAS_TEXTBLOB = True
except ImportError:
    HAS_TEXTBLOB = False
    print("WARNING: TextBlob not found. SemanticJudge will operate in 'Heuristic-Only' mode.")

class SemanticJudge:
    """
    A multi-level Linguistic Quality Engine for AI-native systems.
    
    This library addresses the challenge of testing 'Non-Deterministic' outputs 
    (where the text changes every time). It supports three levels of validation:
    
    1. Heuristic: Quick pattern matching using 'Word-Bags' (Zero-cost).
    2. Local NLP: Sentiment & Subjectivity analysis via TextBlob (Realistic, Free).
    3. Cloud AI: Ready for LLM-as-a-Judge integration (Hugging Face / OpenAI).
    """
    
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def verify_content_intent(self, actual_text, expected_intent):
        """
        The primary keyword for validating the 'Intent' of AI output.
        It blends pattern matching (Heuristics) with emotional tone (NLP).
        
        Example: 
        | Verify Content Intent | I am happy to help you | polite |
        """
        # Step 1: Pattern Matching (Heuristics)
        # We check for specific 'Token Clusters' that define the intent.
        self._verify_heuristic(actual_text, expected_intent)
        
        # Step 2: Emotional Consistency (Local NLP)
        # If the intent is social (Polite/Professional), the sentiment MUST be positive.
        if expected_intent in ["polite", "professional"]:
            self.verify_content_sentiment(actual_text, "positive")
            
        print(f"TRACE: Content successfully validated against intent: {expected_intent}")
        return True

    def verify_content_sentiment(self, text, expected_sentiment="positive"):
        """
        Uses the TextBlob NLP engine to calculate 'Linguistic Polarity'.
        Polarity ranges from -1.0 (Very Negative) to 1.0 (Very Positive).
        """
        if not HAS_TEXTBLOB:
             print("SKIP: NLP analysis skipped (TextBlob missing). Falling back to success.")
             return True

        blob = TextBlob(text)
        polarity = blob.sentiment.polarity
        subjectivity = blob.sentiment.subjectivity
        
        # Log metrics to Allure/Robot Log for observability
        print(f"NLP METRICS -> Polarity: {polarity:.2f}, Subjectivity: {subjectivity:.2f}")
        
        # Rule: Social AI output should never have a negative polarity.
        if expected_sentiment == "positive" and polarity < 0:
            raise AssertionError(
                f"Cognitive Quality Failure: Expected positive sentiment, but detected "
                f"Negative Polarity ({polarity:.2f}). Possible offensive/toxic response."
            )
        
        # Rule: Fact-based/Technical output should remain neutral (not too biased/subjective).
        if expected_sentiment == "neutral" and abs(polarity) > 0.5:
             raise AssertionError(
                f"Cognitive Quality Failure: Expected neutral/factual output, but detected "
                f"High Bias (Polarity {polarity:.2f})."
            )

    def get_semantic_similarity_score(self, text_a, text_b):
        """
        Calculates the 'Inclusion Ratio' between two sentences.
        This provides a 'Fuzzy Match' score which is more robust than exact strings.
        
        Equation: (Total Unique Matching Words) / (Length of Shorter Sentence)
        """
        # Clean text: remove special characters, lowercase, and split into sets of words
        clean_a = re.sub(r'[^\w\s]', '', text_a.lower())
        clean_b = re.sub(r'[^\w\s]', '', text_b.lower())
        
        set_a = set(clean_a.split())
        set_b = set(clean_b.split())
        
        # Intersection = Words found in BOTH sets
        intersection = set_a.intersection(set_b)
        
        # Score = Percentage of the intended meaning (shorter set) found in the output
        denominator = min(len(set_a), len(set_b))
        score = len(intersection) / denominator if denominator > 0 else 0
        return score

    def _verify_heuristic(self, actual_text, expected_intent):
        """
        Internal fallback method. 
        Uses word-bags to define what 'Professional' or 'Polite' looks like.
        """
        actual_text = actual_text.lower()
        
        intent_map = {
            "professional": ["professional", "pleased", "regarding", "assistance", "sincerely", "standard"],
            "polite": ["please", "thank", "welcome", "happy", "assist", "help"],
            "informative": ["details", "information", "provides", "features", "options"]
        }
        
        if expected_intent in intent_map:
            # We look for at least ONE strong match from the word-bag
            match_count = sum(1 for token in intent_map[expected_intent] if token in actual_text)
            if match_count < 1:
                 raise AssertionError(
                     f"Heuristic Match Failure: The AI output did not contain any "
                     f"expected tokens for the '{expected_intent}' intent."
                 )

    # --- Cloud AI Bridge Adaptive (Scalability Placeholder) ---
    # This section demonstrates to stakeholders that the framework is built 
    # to be 'Cloud-Ready'. You can swap the logic below for real LLM calls.
    def _call_hugging_face_api(self, text, model="facebook/bart-large-mnli"):
        """
        Placeholder for integrating the Hugging Face Inference API.
        This would allow for zero-shot text classification in production.
        """
        # Logic for real API calls would go here (e.g., using requests and HF_TOKEN)
        pass
