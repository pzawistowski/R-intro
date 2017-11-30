library(mlr)
library(tidyverse)

train_df = read_csv("data/train.csv") %>%  select(-PassengerId, -Name, -Ticket) %>%
          mutate(Sex = factor(Sex), Cabin = factor(Cabin), Embarked = factor(Embarked))

  
titanic_task = makeClassifTask(id='titanic', data = train_df, target = "Survived")


parallelMap::parallelStartMulticore(level = 'mlr.resample')
results = makeLearner("classif.ctree") %>%  
  resample(task = titanic_task, 
           resampling = cv3, 
           measures = list(mlr::acc, setAggregation(mlr::acc, test.sd)))
parallelMap::parallelStop()


calculateConfusionMatrix(results$pred)
