# segmentfault-hackathon-2016
Shiny从入门到放弃

在刚刚结束的 SegmentFault2016深圳站的活动中，抱着好玩的心态，我们使用Shiny+annyang 完成了一个基于语音识别的即时数据可视化方案。这个灵感一方面是来自2014年谢大大用语音控制统计图表的Demo，另一方面是来自今年TechCrunch Hackathon 纽约站的冠军用语音控制前端页面设计的Demo。

很有意思的是，本次活动的 Top1 也采用了和我们类似的语音识别技术来控制应用的制作，不过由于 Top1 不仅有领先的理念还有优雅的前端设计，整个用户体验也比基于Shiny制作的Web App要高出好几个等级，很遗憾，我们的Demo还是没能打动评委老师和观众朋友。

现在可用的指令集包括：

* show/hide the table    显示/隐藏表格
* show/hide the chart    显示/隐藏图表
* show/hide the forecst  显示/隐藏预测
* download              下载报告

# 示例

```
install.package("shiny")
shiny::runGitHub("harryprince/segmentfault-hackathon-2016")
```
