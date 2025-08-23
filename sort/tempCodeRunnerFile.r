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