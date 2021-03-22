import torch
import torchtext
import os

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

def load_dataset(ngrams=1):
    train_dataset, test_dataset = torchtext.datasets.text_classification.DATASETS['AG_NEWS'](root='./data', vocab=None,ngrams=ngrams)
    classes = ['World', 'Sports', 'Business', 'Sci/Tech']
    vocab_size = len(train_dataset.get_vocab())
    return train_dataset,test_dataset,classes,vocab_size

def train_epoch(net,dataloader,lr=0.01,optimizer=None,loss_fn = torch.nn.CrossEntropyLoss(),epoch_size=None, report_freq=200):
    optimizer = optimizer or torch.optim.Adam(net.parameters(),lr=lr)
    loss_fn = loss_fn.to(device)
    net.train()
    total_loss,acc,count,i = 0,0,0,0
    for labels,features in dataloader:
        optimizer.zero_grad()
        features, labels = features.to(device), labels.to(device)
        out = net(features)
        loss = loss_fn(out,labels) #cross_entropy(out,labels)
        loss.backward()
        optimizer.step()
        total_loss+=loss
        _,predicted = torch.max(out,1)
        acc+=(predicted==labels).sum()
        count+=len(labels)
        i+=1
        if i%report_freq==0:
            print(f"{count}: acc={acc.item()/count}")
        if epoch_size and count>epoch_size:
            break
    return total_loss.item()/count, acc.item()/count

def padify(b):
    # b is the list of tuples of length batch_size
    #   - first element of a tuple = label, 
    #   - second = feature (text sequence)
    # first, compute max length of a sequence in this minibatch
    l = max([len(x[1]) for x in b]) 
    return ( # tuple of two tensors - labels and features
        torch.LongTensor([t[0] for t in b]),
        torch.stack([torch.nn.functional.pad(torch.tensor(t[1]),(0,l-len(t[1])),mode='constant',value=0) for t in b])
    )

def offsetify(b):
    # first, compute data tensor from all sequences
    x = [t[1] for t in b] 
    # now, compute the offsets by accumulating the tensor of sequence lengths
    o = [0] + [len(t[1]) for t in b]
    o = torch.tensor(o[:-1]).cumsum(dim=0)
    return ( 
        torch.LongTensor([t[0] for t in b]), # labels
        torch.cat(x), # text 
        o
    )

def train_epoch_emb(net,dataloader,lr=0.01,optimizer=None,loss_fn = torch.nn.CrossEntropyLoss(),epoch_size=None, report_freq=200):
    optimizer = optimizer or torch.optim.Adam(net.parameters(),lr=lr)
    loss_fn = loss_fn.to(device)
    net.train()
    total_loss,acc,count,i = 0,0,0,0
    for labels,text,off in dataloader:
        optimizer.zero_grad()
        labels,text,off = labels.to(device), text.to(device), off.to(device)
        out = net(text, off)
        loss = loss_fn(out,labels) #cross_entropy(out,labels)
        loss.backward()
        optimizer.step()
        total_loss+=loss
        _,predicted = torch.max(out,1)
        acc+=(predicted==labels).sum()
        count+=len(labels)
        i+=1
        if i%report_freq==0:
            print(f"{count}: acc={acc.item()/count}")
        if epoch_size and count>epoch_size:
            break
    return total_loss.item()/count, acc.item()/count

