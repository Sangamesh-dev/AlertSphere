import torch
import torch.nn as nn
import torch.optim as optim

model = nn.Sequential(
    nn.Linear(input_size, hidden_size),  
    nn.ReLU(),
    nn.Linear(hidden_size, num_classes)  
)

criterion = nn.CrossEntropyLoss()

learning_rate = 0.01
optimizer = optim.SGD(model.parameters(), lr=learning_rate)

num_epochs = 100
for epoch in range(num_epochs):
    for inputs, labels in train_loader:  
        outputs = model(inputs)
        
        loss = criterion(outputs, labels)
        
        optimizer.zero_grad()  
        loss.backward()        
        
        optimizer.step()       
    
    print(f'Epoch [{epoch+1}/{num_epochs}], Loss: {loss.item():.4f}')




