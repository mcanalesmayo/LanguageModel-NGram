# LanguageModel-NGram

## Description

N-gram generalized solutions have O(K^N) storage complexity, where K = number of words, and N = complexity of the Markov chain.
Therefore:
* The ideal solution has O(K^K), which makes it computationally impossible to work
* Bigrams have O(K^2) complexity
* Trigrams have O(K^3) complexity
* ... and so on

The aim of this program is to try the performance of bigrams and trigrams in language modeling problems.

## Author

If you use this code, please reference: Javier Civera - jcivera@unizar.es

Example code (main.m) developed by [Marcos Canales Mayo](https://github.com/MarcosCM)
