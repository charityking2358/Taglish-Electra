# Taglish-Electra
Kumusta Mga Kaibigan and hello friends!
This repository reviews our process for building a bilingual Tagalog-English trained Electra Model. 


### Data Download
Our data consists of two Tagalog datasets equal to approxiamtely 1.5 GB of tagalog training data and 500MB of English. 
1) [WikiText-TL-39](https://s3.us-east-2.amazonaws.com/blaisecruz.com/datasets/wikitext-tl-39/wikitext-tl-39.zip): Large scale, unlabeled Filipino text dataset with 39 Million tokens 
2) [TLUnified Large Scale Corpus](https://www.blaisecruz.com/resources/): Unlabeled Filipino text dataset
3) [openwebtext](https://drive.google.com/drive/folders/1IaD_SIIB-K3Sij_-JjWoPy_UrWqQRdjx?usp=sharing): Small subset of the [open-source project](https://skylion007.github.io/OpenWebTextCorpus/) dataset of 38GB of social media forum posts. 

## Code 

### Environment Setup 
Initialize your conda environment 
```
conda create -n your_env python=3.7
conda activate your_env
git clone https://github.com/charityking2358/Taglish-Electra.git
cd Taglish-Electra
pip install -r requirements.txt
```
### Processing the Data
This bash script combines all of our data and uses the Bert-multilingual-base-cased model to tokenize our corpus. 
```
bash pre-process-data.sh
```

### Pre-training our model 
This script uses the builds the pre-training dataset, uses the Electra pre-training script with parameters, and finally converts all Electra checkpoints to Tensorflow checkpoints to enable Hugginface model submission. 
```
bash train.sh
```
### Pre-trained ELECTRA Models
We released new ELECTRA models in small configurations for discriminators. Our models are available on HuggingFace Transformers and can be used on both PyTorch and Tensorflow. <br> 
Taglish-Electra at [charityking2358/taglish-electra-70k](https://huggingface.co/charityking2358/taglish-electra-70k)

#### To Evaluate Against Benchmark 
1) Hate Speech Setup
We use the [benchmark Tagalog Electra model and annotated hate-speech dataset](https://github.com/jcblaisecruz02/Filipino-Text-Benchmarks#pretrained-electra-models) to determine our model's performance. 
```
git clone https://github.com/jcblaisecruz02/Filipino-Text-Benchmarks.git
mkdir Filipino-Text-Benchmarks/data

# Hatespeech Dataset
wget https://s3.us-east-2.amazonaws.com/blaisecruz.com/datasets/hatenonhate/hatespeech_raw.zip
unzip hatespeech_raw.zip -d Filipino-Text-Benchmarks/data && rm hatespeech_raw.zip
```
2) Run benchmark Electra Model 
```
export DATA_DIR='Filipino-Text-Benchmarks/data/hatespeech'
python Filipino-Text-Benchmarks/train.py \
    --pretrained jcblaise/electra-tagalog-small-cased-discriminator \
    --train_data ${DATA_DIR}/train.csv \
    --valid_data ${DATA_DIR}/valid.csv \
    --test_data ${DATA_DIR}/test.csv \
    --data_pct 1.0 \
    --checkpoint finetuned_model \
    --do_train true \
    --do_eval true \
    --msl 128 \
    --optimizer adam \
    --batch_size 32 \
    --add_token [LINK],[MENTION],[HASHTAG] \
    --weight_decay 1e-8 \
    --learning_rate 2e-4 \
    --adam_epsilon 1e-6 \
    --warmup_pct 0.1 \
    --epochs 3 \
    --seed 42
```
3) Compare our model 
```
python Filipino-Text-Benchmarks/train.py \
    --pretrained charityking2358/taglish-electra-70k \
    --train_data ${DATA_DIR}/train.csv \
    --valid_data ${DATA_DIR}/valid.csv \
    --test_data ${DATA_DIR}/test.csv \
    --data_pct 1.0 \
    --checkpoint finetuned_model \
    --do_train true \
    --do_eval true \
    --msl 128 \
    --optimizer adam \
    --batch_size 32 \
    --add_token [LINK],[MENTION],[HASHTAG] \
    --weight_decay 1e-8 \
    --learning_rate 2e-4 \
    --adam_epsilon 1e-6 \
    --warmup_pct 0.1 \
    --epochs 3 \
    --seed 42
```

