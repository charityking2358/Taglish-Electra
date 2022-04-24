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
conda install pytorch torchvision torchaudio cudatoolkit=10.2 -c pytorch
git clone https://github.com/charityking2358/Taglish-Electra.git
cd Taglish-Electra
pip install -r requirements.txt
```
### Processing the Data
This bash script combines all of our data and tokenizes
```
bash pre-process-data.sh
```

### Pre-training our model 
```
bash train.sh
```
