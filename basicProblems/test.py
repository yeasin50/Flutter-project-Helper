
arr = [1, 2, 3, 4, 5, 6, 7]
d = 2
n = 7
temp = [0]*d

# time O(n), space O(d)
# store in temp array
for i in range(d):
    temp[i]= arr[i]

# swap n amount 
for i in range(n-d):
    arr[i]= arr[i+d]

# initialize temp 
i = n
while i>n-d:
    arr[i-1] = temp[i-n+1]
    i-=1
# print(arr)

# 2nd approch , time O(n*d) space O(1)
n=7
d=2
arr = [1, 2, 3, 4, 5, 6, 7]
for j in range(d):
    temp = arr[0]
    for i in range(n-1):
        arr[i]= arr[i+1]
    arr[n-1] = temp
    

print(arr)

# 3rd approch  
def reverseArray(arr, start, end):
    while(start< end):
        temp = arr[start]
        arr[start] = arr[end]
        arr[end] = temp
        start+=1
        end -=1
        