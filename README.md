#我同济文档#

这是软件工程课程的期末项目

##代码格式##

每行缩进为 **两格**，并且用 **空格** 代替 `Tab` 键，请大家调整编辑器的选项。

代码注释为 **英语**（因为老师的要求）

CSS 里的 class 中用 `-` 而而不是 `_`，和 bootstrap 一致。

##进度##

**12 月 10 日** Sprint1

**12 月 18 日** Sprint2

请点击[这里](https://github.com/greenmoon55/wotongji/issues/milestones)查看详细信息。

以后大概每周一个 sprint。

##文档内容##

全部文档、各种图都放在 QQ 群里，请大家关注文件更新，随时修改。

##如何调试##

首先进入 `wotongji` 目录，然后：

1. 运行

 > bundle install --without production

  安装我们需要的软件包

2. 执行

 > bundle exec rake db:migrate
 
  “更新”数据库

3. 启动服务器
> rails server

4. css 文件在 `app/assets/stylesheets/` 里，生成网页的 .html.erb  文件在 `app/views/` 里。推荐使用 [Chrome 浏览器](https://www.google.com/chrome)，按 `F12` 打开 `开发人员工具`。

##任务分配##
有时我会把任务放在 [Issues](https://github.com/greenmoon55/wotongji/issues) 里，同时你的邮箱里会收到一封提醒的邮件，完成任务后请 Close。

##git的使用##
大家应该基本都会了吧。。

再提醒一下，每次想修改代码之前**都要先 pull**。修改了一定量的代码就要传上来。。

##如何编辑本文档##
这是一个 Markdown 格式的文档。

可以使用记事本或者 [MarkdownPad](http://markdownpad.com) 等任意文本编辑器来编辑。

