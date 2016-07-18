#customAlbumCutOutBox Demo 
   系统自带的相册截取框都是一个矩形，很不好看，当然也可以通过自定义相册的方式来做相册裁剪框，但是比较复杂。  
   通过runtime机制，动态替换系统相册截取框的drawRect方法，从而实现自定义相册截取框，方便快捷

#实现方式
   在navigationController will show时，先判断navigationController的所有子控制器，找到相机截取框的控制器  
   结合class_getInstanceMethod，class_replaceMethod， method_getImplementation，drawRect方法，将相机  
   截取框控制器的View的drawRect方法替换成自定义的drawRect方法。

##我的博客  
   欢迎光临：http://www.cnblogs.com/hepingqingfeng/
