#Grab the Electra repo and Electra to Pytorch conversion repos
git clone https://github.com/google-research/electra.git
git clone https://github.com/lonePatient/electra_pytorch.git

DATA_DIR=data
ENG_DIR=eng_data
TRAIN_SIZE=1000000
TEST_BOOL=true
MODEL_NAME='taglish-electra'

echo "Processing Tagalog datasets"

mkdir -p $DATA_DIR
mkdir -p $ENG_DIR
#Tagalog Dataset1
wget "https://s3.us-east-2.amazonaws.com/blaisecruz.com/datasets/tlunified/tlunified.zip" -O $DATA_DIR/tlunified.zip
#Tagalog Dataset2
wget "https://www.googleapis.com/drive/v3/files/1FN8F-HjPetfCXLgtNBGYFNB0MhHgA8IO?alt=media&key=AIzaSyDFdiwxGZkC1v_J4Q2u7e9vJ6QGSbdDsl8" -O $DATA_DIR/train1.txt
# English Dataset: OpenWebText ~500MB
wget "https://www.googleapis.com/drive/v3/files/16GOW1rDdjLnYhMYH637AyJSs7XsivgoN?alt=media&key=AIzaSyDFdiwxGZkC1v_J4Q2u7e9vJ6QGSbdDsl8" -O $ENG_DIR/eng_data1.txt
unzip $DATA_DIR/tlunified.zip -d $DATA_DIR/


if $TEST_BOOL
then 
	echo 'Using a small subset of each dataset'	
        head -n $TRAIN_SIZE $DATA_DIR/tlunified/train.txt >$DATA_DIR/train2_.txt
        head -n $TRAIN_SIZE $DATA_DIR/train1.txt > $DATA_DIR/train1_.txt
	head -n $TRAIN_SIZE $ENG_DIR/eng_data1.txt > $ENG_DIR/eng_data.txt 
        cat $DATA_DIR/train2_.txt $DATA_DIR/train1_.txt > $DATA_DIR/tag_data_temp.txt
        rm $DATA_DIR/tlunified.zip
        rm -rf $DATA_DIR/tlunified/
        rm $DATA_DIR/train1.txt
	rm $DATA_DIR/train2_.txt $DATA_DIR/train1_.txt
	rm $ENG_DIR/eng_data1.txt

else
	echo 'Using the Full Tagalog and English Datasets'
	cat $DATA_DIR/tlunified/train.txt $DATA_DIR/train1.txt > $DATA_DIR/tag_data_temp.txt
	mv $ENG_DIR/eng_data1.txt $ENG_DIR/eng_data.txt
	rm -rf $DATA_DIR/tlunified/
	rm $DATA_DIR/train1.txt
	rm $DATA_DIR/tlunified.zip

		

fi

echo "Call Tagalong and English-Based tokenizers"
#Build Tokenizers
python tokenizer.py --Lang 'filipino' --Data $DATA_DIR/tag_data_temp.txt --Output $DATA_DIR
python tokenizer.py --Lang 'english' --Data $ENG_DIR/eng_data.txt --Output $ENG_DIR

#Combine Datasets and Tokenizer Vocabulary Output into main vocab file
#python combine_vocab.py --txt1 $DATA_DIR/vocab.txt --txt2 $ENG_DIR/vocab.txt --Output $DATA_DIR


