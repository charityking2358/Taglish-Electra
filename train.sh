
DATA_DIR=data
MODEL_NAME='taglish-electra'
MODEL_DIR=data/models/taglish-electra

echo "Building Pre-Training Dataset"
python electra/build_pretraining_dataset.py \
  --corpus-dir $DATA_DIR \
  --vocab-file $DATA_DIR/vocab.txt \
  --output-dir $DATA_DIR/pretrain_tfrecords \
  --max-seq-length 128 \
  --blanks-separate-docs False \
  --no-lower-case \
  --num-processes 5

echo "Starting Pre-Training of Electra Model, diyos ko Wo0T!!!!!!!!!!!"

python electra/run_pretraining.py \
  --data-dir $DATA_DIR \
  --model-name $MODEL_NAME \
  --hparams '{"do_train": "true",
    "do_eval": "false",
    "model_size": "small",
    "do_lower_case": "false",
    "vocab_size": 30101,
    "num_train_steps": 200,
    "save_checkpoints_steps": 100,
    "generator_hidden_size": 1.0,
    "train_batch_size": 32}'

#python electra_pytorch/convert_electra_tf_checkpoint_to_pytorch.py \
#    --tf_checkpoint_path=$MODEL_DIR \
#    --pytorch_dump_path=$MODEL_DIR/pytorch_model.bin \
#    --electra_config_file='{"vocab_size": 30097,
#  			"embedding_size": 128,
#  			"hidden_size": 256,
#  			"num_hidden_layers": 12,
#  			"num_attention_heads": 4,
#  			"intermediate_size": 1024,
#  			"generator_size":"0.25",
#  			"hidden_act": "gelu",
#  			"hidden_dropout_prob": 0.1,
# 	 		"attention_probs_dropout_prob": 0.1,
#  			"max_position_embeddings": 512,
#  			"type_vocab_size": 2,
#  			"initializer_range": 0.02}'

