#!/bin/bash
# array.sh

# 创建包含3个元素的数组
fruits=("apple" "banana" "cherry")

#访问数组的第1、2个元素
echo "${fruits[0]}"
echo "${fruits[1]}"

# 获取数组的长度 知识点：$#
length=${#fruits[@]}
echo "Number of fruits: $length"

# 遍历数组，知识点：[@] 循环
for fruit in "${fruits[@]}"; do
	echo "${fruit}"
done

# 知识点：类C的新增数组元素模式
fruits+=("date")
echo "${fruits[@]}"

# 知识点：删除指定index位置的元素
unset fruits[1]
echo "${fruits[@]}"

# 通过切片/slice提取制作子数组
subarray=("${fruits[@]:1:2}")
echo "${subarray[@]}"

#合并数组：提取每个数组的元素，然后放在()里面组合
vegetables=("carrot" "potato")
combined=("${fruits[@]}" "${vegetables[@]}")
echo "${combined[@]}"


#以下是高阶用法
#
#数组排序：1使用for循环逐个回显输出数组元素，然后再使用现成的sort命令排序
sorted_fruits=($(for fruit in "${fruits[@]}"; do echo "$fruit"; done | sort ))
echo "Sorted fruits: ${sorted_fruits[@]}"

# 正则表达式=～的用法：关键词在后面
# The =~ Regular Expression matching operator within a double brackets test expression. 
search="date"
if [[ "${fruits[@]} " =~ " ${search} " ]]; then
	echo "$search is in the array."
else
	echo "$search is not in the array."
fi


# 定义关联数组，然后用关联特性来计数
# 关联数据具有原数组的元素属性，可以利用这个来回显计数结果
# An associative array can be thought of as a set of two linked arrays 
# -- one holding the data, 
# and the other the keys that index the individual elements of the data array.
declare -A count_map
for fruit in "${fruits[@]}"; do
	(( count_map[$fruit]++ ))
done

for fruit in "${!count_map[@]}"; do
	echo "$fruit: ${count_map[$fruit]}"
done

#将两个数组合并在一起
more_fruits=("kiwi" "mango")
all_fruits=("${fruits[@]}" "${more_fruits[@]}")
echo "All frults: ${all_fruits[@]}"


#利用数组的indice递减来逆向提取元素，并赋予一个新的数组
reversed_fruits=()
for ((i=${#all_fruits[@]}-1; i>=0;i--)); do
	reversed_fruits+=("${all_fruits[i]}")
done
echo "Reversed fruits: ${reversed_fruits[@]}"


empty_array=()
empty_array+=("first")
empty_array+=("second")
echo "Empty_array: ${empty_array[@]}"


#位置参数/positional parameter的特性
print_array(){
	local arr=("$@")
	for item in "${arr[@]}"; do
		echo "$item"
	done
}

print_array "${all_fruits[@]}"
