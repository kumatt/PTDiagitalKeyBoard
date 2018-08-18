# PTDiagitalKeyBoard

iOS系统提供了多种键盘，我们可以通过Enum类型设置。但有的时候由于某些特殊业务的需要，我们不得不自定义键盘。

自定义键盘最关键的部分是替换系统键盘的显示逻辑，然而官方已经帮我们封装好了相关逻辑，需要做的只是把自定义键盘赋给输入框,交由系统来管理自定义键盘。

```Objective-C
    self.textfield.inputView = digitalKeyBoardView;
```

重点在于键盘的构建及将输出的内容显示到输入框中，输入框都遵循了`<UITextInput>`协议，只需要根据协议来获取输入框相关状态、改变输入框的文本。

```Objective-C
//退格
- (void)event_delete
{
    UIResponder <UITextInput>*firstResponse = (id)self.nextResponder;

    [firstResponse deleteBackward];
}

// 添加字符串
- (void)event_addCharacter:(NSString *)string
{
    UIResponder <UITextInput> *firstResponse = (id)self.nextResponder;

    UITextRange *range = firstResponse.markedTextRange;
    if (range == nil) {
        range = firstResponse.selectedTextRange;
    }
    if ([firstResponse respondsToSelector:@selector(shouldChangeTextInRange:replacementText:)] && [firstResponse shouldChangeTextInRange:range replacementText:string] == NO) {
        return;
    }
    [firstResponse replaceRange:range withText:string];
}
```

[自定义输入法](http://www.cocoachina.com/ios/20140918/9677.html)

[UITextInput协议参考](http://blog.sina.com.cn/s/blog_5ff81ab001011s9m.html)
