# 通过配置文件更改Typora的字体颜色

## 解决方案：

- 一般网上的方法是添加css样式来改变字体颜色：

```css
<span style="color:red"></span>
```

- 但是每次这样添加太麻烦，你可以找到配置文件：文件→偏好设置→外观→打开主题文件夹→打开github.css（你自己使用哪个主题，就打开哪个文件）
- 在任意位置添加如下代码：

```css
strong {
    font-weight: bold;  //字体加粗，normal为正常字体
    color: red;         //颜色为红色
}
```

这个方法实际上就是将**加粗的样式进行了重写**，快捷键仍然是加粗的快捷键：**ctrl+B**

## 补充：

你也可以添加如下代码，改变高亮颜色：

```css
mark {
    background: pink;   //mark就是高亮的意思，backgroud是背景色
}
```

