var rab_load = new PreLoad.HbObject_RabbitLoading();
rab_load.setTransform(340,200);
stage.addChild(rab_load);

import { MASK } from './StageMask.js';

var octopus = new PreLoad.HbObject_Octopus();
octopus.stop(); // 停止在第 1 帧
octopus.mask = MASK;
stage.addChild(octopus);

var easingFactorOctopus = 0.1;
let isEatingMouse = false;
let isEatenMouse = false;

createjs.Ticker.addEventListener("tick", followMouse);

function followMouse(event) {
    // 计算缓动追随
    const dx = stage.mouseX - octopus.x; // 鼠标和 octopus 的 X 差值
    const dy = stage.mouseY - octopus.y; // 鼠标和 octopus 的 Y 差值

    octopus.x += dx * easingFactorOctopus; // 缓动追随 X 轴
    octopus.y += dy * easingFactorOctopus; // 缓动追随 Y 轴
	
    const distance = Math.sqrt(dx * dx + dy * dy); // 计算鼠标与 octopus 的距离
	
    if (distance > 250) {
        //octopus.gotoAndStop(0);
        easingFactorOctopus = 0.1;
        isEatingMouse = false;
        isEatenMouse = false;
        isMouseDownEnabled = true;
        isMouseUpEnabled = true;
        currentCursor.visible = true;
    }

    if (!isEatenMouse) {
        if (distance < 6) {
            // 鼠标与 octopus 距离小于 6 像素时，跳转到帧 3
            if (!isEatingMouse) {
                octopus.gotoAndStop(3); // 跳转到帧 3
                isEatenMouse = true;
                isEatingMouse = true; // 标记为在帧 3 内

                // 监听第3帧内动画的完成
				const clip = octopus.getChildByName("Eating");
				if (clip) {
					clip.gotoAndPlay(0); // 确保子对象动画从头播放
					clip.on("tick", waitForSubTimelineComplete); // 添加监听器
				}
            }
        } else if (distance >= 55 && Math.abs(dx) < Math.abs(dy)) {
            // 鼠标在正上方或正下方且距离大于等于 55
            octopus.gotoAndStop(2);
            isEatingMouse = false;
        } else if (dx > 0) {
            // 鼠标在右边
            octopus.gotoAndStop(0);
            isEatingMouse = false;
        } else if (dx < 0) {
            // 鼠标在左边
            octopus.gotoAndStop(1);
            isEatingMouse = false;
        }
    }

    if (isEatingMouse) {
        easingFactorOctopus = 0.5;
        isMouseDownEnabled = false;
        isMouseUpEnabled = false;
        currentCursor.visible = false;
    }
}

// 等待第3帧动画完成的函数
function waitForSubTimelineComplete(event) {
    const clip = event.target; // 获取正在监听的子时间轴对象
    if (clip.currentFrame === clip.totalFrames - 1) {
        // 子时间轴动画播放完成后
        octopus.gotoAndStop(4); // 跳转到帧4
        clip.removeEventListener("tick", waitForSubTimelineComplete); // 移除监听器
    }
}

var rab_queue = new createjs.LoadQueue();
// 设置加载文件的清单
var rab_resources = [
						  "http://8.152.163.191/res/pet/swf/1.swf",
						  "http://8.152.163.191/res/pet/swf/2.swf",
						  "http://8.152.163.191/res/pet/swf/3.swf",
						  "http://8.152.163.191/res/pet/swf/4.swf",
						  "http://8.152.163.191/res/pet/swf/5.swf",
						  "http://8.152.163.191/res/pet/swf/6.swf",
						  "http://8.152.163.191/res/pet/swf/7.swf",
						  "http://8.152.163.191/res/pet/swf/8.swf",
						  "http://8.152.163.191/res/pet/swf/9.swf",
						  "http://8.152.163.191/res/pet/swf/10.swf",
						  "http://8.152.163.191/res/pet/swf/11.swf",
						  "http://8.152.163.191/res/pet/swf/12.swf",
						  "http://8.152.163.191/res/pet/swf/13.swf",
						  "http://8.152.163.191/res/pet/swf/14.swf",
						  "http://8.152.163.191/res/pet/swf/15.swf",
						  "http://8.152.163.191/res/pet/swf/16.swf",
						  "http://8.152.163.191/res/pet/swf/17.swf",
						  "http://8.152.163.191/res/pet/swf/18.swf",
						  "http://8.152.163.191/res/pet/swf/19.swf",
						  "http://8.152.163.191/res/pet/swf/20.swf",
						  "http://8.152.163.191/res/pet/swf/21.swf",
						  "http://8.152.163.191/res/pet/swf/22.swf",
						  "http://8.152.163.191/res/pet/swf/23.swf",
						  "http://8.152.163.191/res/pet/swf/24.swf",
						  "http://8.152.163.191/res/pet/swf/25.swf",
						  "http://8.152.163.191/res/pet/swf/26.swf",
						  "http://8.152.163.191/res/pet/swf/27.swf",
						  "http://8.152.163.191/res/pet/swf/28.swf",
						  "http://8.152.163.191/res/pet/swf/29.swf",
						  "http://8.152.163.191/res/pet/swf/30.swf",
						  "http://8.152.163.191/res/pet/swf/31.swf",
						  "http://8.152.163.191/res/pet/swf/32.swf",
						  "http://8.152.163.191/res/pet/swf/33.swf",
						  "http://8.152.163.191/res/pet/swf/34.swf",
						  "http://8.152.163.191/res/pet/swf/35.swf",
						  "http://8.152.163.191/res/pet/swf/36.swf",
						  "http://8.152.163.191/res/pet/swf/37.swf",
						  "http://8.152.163.191/res/pet/swf/38.swf",
						  "http://8.152.163.191/res/pet/swf/39.swf",
						  "http://8.152.163.191/res/pet/swf/40.swf",
						  "http://8.152.163.191/res/pet/swf/41.swf",
						  "http://8.152.163.191/res/pet/swf/42.swf",
						  "http://8.152.163.191/res/pet/swf/43.swf",
						  "http://8.152.163.191/res/pet/swf/44.swf",
						  "http://8.152.163.191/res/pet/swf/45.swf",
						  "http://8.152.163.191/res/pet/swf/46.swf",
						  "http://8.152.163.191/res/pet/swf/47.swf",
						  "http://8.152.163.191/res/pet/swf/48.swf",
						  "http://8.152.163.191/res/pet/swf/49.swf",
						  "http://8.152.163.191/res/pet/swf/50.swf",
						  "http://8.152.163.191/res/pet/swf/51.swf",
						  "http://8.152.163.191/res/pet/swf/52.swf",
						  "http://8.152.163.191/res/pet/swf/53.swf",
						  "http://8.152.163.191/res/pet/swf/54.swf",
						  "http://8.152.163.191/res/pet/swf/55.swf",
						  "http://8.152.163.191/res/pet/swf/56.swf",
						  "http://8.152.163.191/res/pet/swf/57.swf",
						  "http://8.152.163.191/res/pet/swf/58.swf",
						  "http://8.152.163.191/res/pet/swf/59.swf",
						  "http://8.152.163.191/res/pet/swf/60.swf",
						  "http://8.152.163.191/res/pet/swf/61.swf",
						  "http://8.152.163.191/res/pet/swf/62.swf",
						  "http://8.152.163.191/res/pet/swf/63.swf",
						  "http://8.152.163.191/res/pet/swf/64.swf",
						  "http://8.152.163.191/res/pet/swf/65.swf",
						  "http://8.152.163.191/res/pet/swf/66.swf",
						  "http://8.152.163.191/res/pet/swf/67.swf",
						  "http://8.152.163.191/res/pet/swf/68.swf",
						  "http://8.152.163.191/res/pet/swf/69.swf",
						  "http://8.152.163.191/res/pet/swf/70.swf",
						  "http://8.152.163.191/res/pet/swf/71.swf",
						  "http://8.152.163.191/res/pet/swf/72.swf",
    // 你可以继续添加更多资源
];

const rab_totalFiles = rab_resources.length; // 总文件数量
let rab_loadedFiles = 0; // 已加载文件数

// 添加文件加载进度监听
rab_queue.on("progress", (event) => {
    // 根据加载进度更新加载条的帧数
    const progress = Math.floor(event.progress * 600); // 获取加载进度百分比
    rab_load.children[0].gotoAndStop(progress); // 跳转到对应的帧数，假设进度条有600帧
    
    // 计算已加载百分比
    const loadedPercentage = Math.floor((rab_loadedFiles / rab_totalFiles) * 100);
    
    // 更新进度文本框
    rab_load.progressText.text = `${loadedPercentage}%`; // 更新文本为加载进度百分比
    //console.log(`加载进度: ${loadedPercentage}%`); // 打印加载进度
});

// 监听加载完成事件
rab_queue.on("complete", () => {
    // 当所有资源加载完成时，可以让加载条播放到最后一帧
    rab_load.gotoAndStop(600);
    // 更新文本框为100%
    rab_load.progressText.text = "100%";
    rab_queue.removeAllEventListeners();
    stage.removeChild(rab_load);
	stage.removeChild(octopus);
	currentCursor.visible = true;
	createjs.Ticker.removeEventListener("tick", followMouse);
    import('./sb.js');
});

// 监听每个文件加载完成的事件
rab_queue.on("fileload", () => {
    rab_loadedFiles++; // 已加载文件数 +1
});

// 开始加载资源
rab_queue.loadManifest(rab_resources);