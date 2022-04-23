
DATA_DIR=data
MODEL_NAME='taglish-electra'
PARAMS=hparams.json


echo "Building Pre-Training Dataset"
#python electra/build_pretraining_dataset.py \
#  --corpus-dir $DATA_DIR \
#  --vocab-file $DATA_DIR/vocab.txt \
#  --output-dir $DATA_DIR/pretrain_tfrecords \
#  --max-seq-length 128 \
#  --blanks-separate-docs False \
#  --no-lower-case \
#  --num-processes 5

echo "Starting Pre-Training of Electra Model, diyos ko Wo0T!!!!!!!!!!!"

python electra/run_pretraining.py \
  --data-dir $DATA_DIR \
  --model-name $MODEL_NAME \
  --hparams '{"do_train": "true",
    "do_eval": "false",
    "model_size": "small",
    "do_lower_case": "false",
    "vocab_size": 59097,
    "num_train_steps": 300,
    "save_checkpoints_steps": 100,
    "train_batch_size": 32}'
