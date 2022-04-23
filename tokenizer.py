
import argparse
from transformers import AutoTokenizer

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Pre-Processing Tokenizer')
    parser.add_argument('--Lang', type=str, help='Language of Data for Tokenizer. Use strings "filipino" or "english" ', required=True)
    parser.add_argument('--Data', type=str, help='File Path for data to be tokenized', required=True)
    parser.add_argument('--Output', type=str, help='File Path for Token files', required=True)
    args = parser.parse_args()

    lang = args.Lang
    data = args.Data
    out_data = args.Output

    if lang == 'filipino': 
        model = 'jcblaise/bert-tagalog-base-cased'
    
    elif lang == 'english':
        model = 'bert-base-cased'
    
    else:
        print ("Language not supported by tokenizers") 
        quit

    tokenizer = AutoTokenizer.from_pretrained(model)
    tokenizer.save_pretrained(out_data)

