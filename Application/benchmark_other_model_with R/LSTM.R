# create LSTM net
LSTM <- function(data,lag = 3,seasonal_lag=1,test_size=24)
{
  # data normalization
  max_value <- max(data)
  min_value <- min(data)
  spread <- max_value - min_value
  data_norm <- (data - min_value) / spread
  
  
  # create dataset
  l=length(data_norm)
  # size of dataX
  dataX_row<-l - (11+seasonal_lag)
  dataX_col<-lag+seasonal_lag
  dataX <- array(dim = c(dataX_row, dataX_col))
  # i from 12+seasonal_lag to l
  for (i in (12+seasonal_lag):l)
  {
    dataX[i-(11+seasonal_lag),]<- c(data_norm[(i-(11+seasonal_lag)):(i-12)],data_norm[(i-lag):(i-1)])
  }
  dataY <- array(data_norm[(12+seasonal_lag):l],
                 dim = c(dataX_row, 1))
  
  
  # train_size and test_size
  train_size <- dataX_row- test_size
  
  trainXY<-list(
    dataX = dataX[1:train_size,],
    dataY = dataY[1:train_size,])
  
  testXY<-list(
    dataX = dataX[(train_size+1):length(dataY),],
    dataY = dataY[(train_size+1):length(dataY),])
  
  
  train_dim <- dim(trainXY$dataX)
  test_dim <- dim(testXY$dataX)
  
  # reshape input to be [samples, time steps, features]
  dim(trainXY$dataX) <- c(train_dim[1], 1, train_dim[2])
  dim(testXY$dataX) <- c(test_dim[1], 1, test_dim[2])
  
  # new model
  model <- keras_model_sequential()
  
  # fit model
  model %>%
    layer_lstm(
      units = 4,
      input_shape = c(1, dataX_col)) %>%
    layer_dense(
      units = 1) %>%
    compile(
      loss = 'mean_squared_error',
      optimizer = 'adam') %>%
    fit(trainXY$dataX,
        trainXY$dataY,
        epochs = 100,
        batch_size = 1,
        verbose = 2)
  
  
  # train value
  trainPredict <- model %>%
    predict(
      trainXY$dataX,
      verbose = 2)
  
  
  # test value by iterative prediction
  data_norm_recu<- vector(mode="numeric",length=l)
  data_norm_recu[1:(l-test_size)]<-data_norm[1:(l-test_size)]
  for (i in (l-test_size+1):l)
  {
    test_one_step<-c(data_norm_recu[(i-(11+seasonal_lag)):(i-12)],data_norm[(i-lag):(i-1)])
    test_one<-list(
      dataX = test_one_step,
      dataY = data_norm[i])
    # reshape input to be [samples, time steps, features]
    dim(test_one$dataX) <- c(1, 1, lag+seasonal_lag)
    test_one_predict<-model %>%
      predict(
        test_one$dataX,
        verbose = 2)
    data_norm_recu[i]<-test_one_predict
  }
  testPredict <- data_norm_recu[(l-test_size+1):l]
  
  trainPredict <- trainPredict * spread + min_value
  testPredict <- testPredict * spread + min_value
  
  Predict<-c(trainPredict,testPredict)
  return(Predict)
}