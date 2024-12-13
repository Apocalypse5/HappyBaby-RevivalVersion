// 定义鼠标指针实例
const cursorDefault = new PreLoad.HbObject_Cursor();
const cursorClick = new PreLoad.HbObject_CursorClick();
const cursorCatch = new PreLoad.HbObject_CursorCatch();
let currentCursor = cursorDefault;

// 添加默认鼠标指针到舞台
stage.addChild(currentCursor);
currentCursor.mouseEnabled = false; // 禁止自定义指针响应鼠标事件（非常重要）
currentCursor.x = stage.mouseX;
currentCursor.y = stage.mouseY;

// 禁用系统默认鼠标指针
stage.enableMouseOver(10);
document.body.style.cursor = "none";

// 鼠标移动更新指针位置
stage.on("stagemousemove", (event) => {
    currentCursor.x = event.stageX;
    currentCursor.y = event.stageY;
    stage.setChildIndex(currentCursor, stage.numChildren - 1);
});

// 鼠标按下切换为点击指针
stage.on("stagemousedown", (event) => {
    currentCursor.visible = false; // 隐藏当前指针
    currentCursor = cursorClick; // 切换为点击指针
    currentCursor.x = event.stageX; // 同步位置
    currentCursor.y = event.stageY;
    currentCursor.visible = true; // 显示新的点击指针
    stage.addChild(currentCursor);
});

// 全局监听鼠标释放事件
stage.on("stagemouseup", (event) => {
    currentCursor.visible = false; // 隐藏当前指针
    currentCursor = cursorDefault; // 切换回默认指针
    currentCursor.x = stage.mouseX; // 使用舞台鼠标坐标
    currentCursor.y = stage.mouseY;
    currentCursor.visible = true; // 显示新的默认指针
    stage.addChild(currentCursor);
});

// 检测鼠标离开或进入画布的事件
const canvasElement = document.querySelector("canvas"); // 获取画布元素

canvasElement.style.cursor = "none"; // 禁用画布区域的系统鼠标指针

setInterval(() => {
    canvasElement.style.cursor = "none"; // 隐藏鼠标指针
}, 100);

canvasElement.addEventListener("mouseleave", () => {
    // 鼠标离开画布范围时恢复系统鼠标样式并隐藏自定义指针
    document.body.style.cursor = "default"; // 恢复系统鼠标
    currentCursor.visible = false; // 隐藏自定义鼠标指针
});

canvasElement.addEventListener("mouseenter", () => {
    // 鼠标回到画布时禁用系统鼠标并显示自定义指针
    document.body.style.cursor = "none"; // 隐藏系统鼠标
    currentCursor.visible = true; // 显示自定义鼠标指针
});