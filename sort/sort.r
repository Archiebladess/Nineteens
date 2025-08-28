library(readr)
library(cld3)
library(dplyr)
library(tidytext)
library(tidyverse)

sample <- read_csv("C:/Users/FLORENTINA REGITA/Downloads/data-analysis-competition-2025/sample_submission.csv")

test_gpt <- read_csv("C:/Users/FLORENTINA REGITA/Downloads/data-analysis-competition-2025/Test/gpt.csv")
test_claude <- read_csv("C:/Users/FLORENTINA REGITA/Downloads/data-analysis-competition-2025/Test/claude.csv")
test_gemini <- read_csv("C:/Users/FLORENTINA REGITA/Downloads/data-analysis-competition-2025/Test/gemini.csv")
test_deepseek <- read_csv("C:/Users/FLORENTINA REGITA/Downloads/data-analysis-competition-2025/Test/deepseek.csv")
test_grok <- read_csv("C:/Users/FLORENTINA REGITA/Downloads/data-analysis-competition-2025/Test/grok.csv")
test_perplexity <- read_csv("C:/Users/FLORENTINA REGITA/Downloads/data-analysis-competition-2025/Test/perplexity.csv")

train_gpt <- read_csv("C:/Users/FLORENTINA REGITA/Downloads/data-analysis-competition-2025/Train/gpt.csv")
train_claude <- read_csv("C:/Users/FLORENTINA REGITA/Downloads/data-analysis-competition-2025/Train/claude.csv")
train_gemini <- read_csv("C:/Users/FLORENTINA REGITA/Downloads/data-analysis-competition-2025/Train/gemini.csv")
train_deepseek <- read_csv("C:/Users/FLORENTINA REGITA/Downloads/data-analysis-competition-2025/Train/deepseek.csv")
train_grok <- read_csv("C:/Users/FLORENTINA REGITA/Downloads/data-analysis-competition-2025/Train/grok.csv")
train_perplexity <- read_csv("C:/Users/FLORENTINA REGITA/Downloads/data-analysis-competition-2025/Train/perplexity.csv")

#gabungin semua data test dan train ke dalam list
df_test <- list(test_gpt, test_claude, test_gemini, test_deepseek, test_grok, test_perplexity)
df_train <- list(train_gpt, train_claude, train_gemini, train_deepseek, train_grok, train_perplexity)

#cek tipe data
str(sample)
lapply(run_test, str)
lapply(run_train, str)

#cek missing value dan hapus missing value
cek_sample <- colSums(is.na(sample))
cek_test <- lapply(run_test, function(df) print(colSums(is.na(df))))
cek_train <- lapply(run_train, function(df) print(colSums(is.na(df))))

new_sample <- na.omit(sample)
new_test <- lapply(df_test, na.omit)
new_train <- lapply(df_train, na.omit)

#cek duplikat
duplikat_sample <- duplicated(sample)
duplikat_test <- lapply(run_test, duplicated)
duplikat_train <- lapply(run_train, duplicated)

double_sample <- sum(duplikat_sample)
double_test <- lapply(duplikat_test, sum)
double_train <- lapply(duplikat_train, sum)

#standarisasi format data
clean_test <- lapply(new_test, function(df) {
  df$Comment <- trimws(df$Comment)
  df
})

#sorting ascending
sort_sample <- sample[order(new_sample$Sentiment), ]
sort_sample
sort_test <- lapply(new_test, function(df) {
  df$At <- as.POSIXct(df$At)
  df[order(df$At, df$AppVersion), ]
})
sort_test
sort_train <- lapply(new_train, function(df) {
  df$At <- as.POSIXct(df$At)
  df_Appversion <- suppressWarnings(as.numeric(gsub("[^0-9.]", "", df$AppVersion)))
  df[order(df$Sentiment, df$At, df_Appversion), ]
})
sort_train

#sorting bahasa
language <- function(df) {
  df$Language <- cld3::detect_language(df$Comment)
  df
}

detected_test <- lapply(clean_test, language)
table(detected_test[[1]]$Language)

detected_train <- lapply(clean_train, language)
table(detected_train[[1]]$Language)

#klasifikasi comment positive, negative, neutral train
positive_comments_train <- lapply(new_detected_train, function(df) {
  df[df$Sentiment == 2, ]
})

negative_comments_train <- lapply(new_detected_train, function(df) {
  df[df$Sentiment == 0, ]
})

neutral_comments_train <- lapply(new_detected_train, function(df) {
  df[df$Sentiment == 1, ]
})

#klasifikasi comment positive, negative, neutral test
df2 <- df2 %>%
  mutate(comment_id = row_number())

kata_df <- df2 %>%
  unnest_tokens(word, Comment)

custom_lexicon <- tibble(
  word = c("badiya", "achcha", "ভালো"),
  sentiment = c("positive", "positive", "positive")
)

bing_lexicon <- get_sentiments("bing") %>%
  bind_rows(custom_lexicon)

kata_df_sentimen <- kata_df %>%
  left_join(bing_lexicon, by = "word") %>%
  mutate(sentiment = ifelse(is.na(sentiment), "neutral", sentiment))

komentar_sentimen <- kata_df_sentimen %>%
  group_by(comment_id) %>%
  count(sentiment) %>%
  pivot_wider(names_from = sentiment, values_from = n, values_fill = 0)

hasil_klasifikasi <- df2 %>%
  left_join(komentar_sentimen, by = "comment_id") %>%
  mutate(
    total = positive + negative + neutral,
    prop_pos = positive / total,
    prop_neg = negative / total,
    klasifikasi = case_when(
      prop_pos >= 0.3 ~ "positif",
      prop_neg >= 0.3 ~ "negatif",
      TRUE ~ "netral"
    )
  )

hasil_klasifikasi_test <- hasil_klasifikasi %>%
  select(CommentId, Comment, At, AppVersion, klasifikasi)
hasil_klasifikasi_test