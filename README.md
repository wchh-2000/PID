## PID 控制仿真 ##
假设一个小车从初始位置（一维的）x=-100开始运动，目标位置为x=0，位置坐标x为受控对象。利用增量式PID控制小车的位置变化量。
位置坐标的迭代公式为：

*x(k)=x(k-1)+v(k-1)dt*

 由于dt在仿真过程中为常数，所以速度即为调节量。

位置-时间曲线仿真结果：

![](https://github.com/wchh-2000/PID/raw/master/images/xv.png)  

调节PID参数的效果：

![](https://github.com/wchh-2000/PID/raw/master/images/kp.png)  

上图可见增大比例调节系数Kp，系统更快稳定。

![](https://github.com/wchh-2000/PID/raw/master/images/ki.png)  

上图可见增大积分调节系数Ki，波动更剧烈，变化更快。
