library(readr)

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

run <- function(head){
    for (df in df_test) {
        print(head(df))
    }
}

run_test <- run(df_test)
run_train <- run(df_train)

#sorting ascending
sort_sample <- sample[order(new_sample$Sentiment), ]
sort_test <- lapply(new_test, function(df) df[order(df$CommentId), ])
sort_train <- lapply(new_train, function(df) df[order(df$Sentiment), ])

#standarisasi format data
clean_test <- lapply(new_test, function(df) {
  df$Comment <- trimws(df$Comment)
  df
})

#cek tipe data
str(sample)
lapply(run_test_test, str)
lapply(run_train, str)

#cek missing value dan hapus missing value
cek_sample <- colSums(is.na(sample))
cek_test <- lapply(run_test, function(df) print(colSums(is.na(df))))
cek_train <- lapply(run_train, function(df) print(colSums(is.na(df))))

new_sample <- na.omit(sample)
new_test <- lapply(run_test, na.omit)
new_train <- lapply(run_train, na.omit)

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