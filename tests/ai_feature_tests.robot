*** Settings ***
Documentation       Demo suite showcasing Actual NLP (Natural Language Processing).
...                 This suite uses TextBlob via the SemanticJudge library to verify 
...                 Sentiment Polarity and Cognitive Intent.

Library             ../resources/Libraries/SemanticJudge.py
Resource            ../resources/common.resource

Test Tags           ai-native    nlp-validation    cognitive-quality


*** Variables ***
# Simulated AI Outputs
${CS_POSITIVE_RESPONSE}     I am happy to assist you today! Thank you for reaching out to us.
${TECH_NEUTRAL_RESPONSE}    The system has 4 cores and 16GB of RAM. It operates at 2.4GHz.
${ANGRY_BOT_RESPONSE}       I won't help you. This is a waste of my time. Leave now.


*** Test Cases ***
Verify Customer Success AI Sentiment
    [Documentation]    Uses Real NLP to verify that the AI is being 'Positive'.
    Verify Content Sentiment    ${CS_POSITIVE_RESPONSE}    expected_sentiment=positive

Verify Technical Output Is Fact-Based (Neutral)
    [Documentation]    Ensures technical descriptions are neutral and unbiased.
    Verify Content Sentiment    ${TECH_NEUTRAL_RESPONSE}    expected_sentiment=neutral

Verify Aggressive Toxicity Filter (Negative Test)
    [Documentation]    Demonstrates how NLP detects negative or 'toxic' AI responses.
    Run Keyword And Expect Error    *Negative Polarity*
    ...    Verify Content Sentiment    ${ANGRY_BOT_RESPONSE}    expected_sentiment=positive

Hybrid Intent and Sentiment Validation
    [Documentation]    Covers both word-bag heuristics and NLP sentiment in one call.
    Verify Content Intent    ${CS_POSITIVE_RESPONSE}    polite

Check Semantic Intent Coverage
    [Documentation]    Measures the inclusion of intent keywords.
    ${score}=    Get Semantic Similarity Score    ${CS_POSITIVE_RESPONSE}    happy assist thank
    Log    Intent Coverage Score: ${score}
    Should Be True    ${score} > 0.8
