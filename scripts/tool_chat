import json
import os

from openai import OpenAI
from transformers.utils.versions import require_version

require_version("openai>=1.5.0", "To fix: pip install openai>=1.5.0")

client = OpenAI(
    api_key="{}".format(os.environ.get("API_KEY", "0")),
    base_url="http://localhost:{}/v1".format(os.environ.get("API_PORT", 8000)),
)
tools_path = r"json_schema_tools.json"
with open(tools_path, 'r', encoding='utf-8') as file:
    tools_temp = json.load(file)
tools = []
for item in tools_temp:
    tools.append({"type": "function", "function": item})
# tools = [{"type": "function", "function": {"name": "CloseAir", "description": "关闭空调", "parameters": {"type": "object", "properties": {}}}},
#  {"type": "function", "function": {"name": "WindowSlit", "description": "车窗开缝", "parameters": {"type": "object", "properties": {}}}}]


def remoteController(**kwargs):
    return json.dumps({'code': 0, 'msg': '操作成功'}, ensure_ascii=False)


tool_map = {'OpenAir': remoteController, 'CloseAir': remoteController,
            'UnLockDoor': remoteController, 'LockDoor': remoteController, 'OpenWindow': remoteController,
            'CloseWindow': remoteController, 'WindowSlit': remoteController, 'OpenDormer': remoteController,
            'CloseDormer': remoteController, 'SteeringWheelHeating': remoteController,
            'OpenTrunk': remoteController, 'CloseTrunk': remoteController, 'RemoteSearchCar': remoteController,
            'SeatHeating': remoteController, 'SeatVentilation': remoteController, 'sentryMode': remoteController,
            'OpenFragrance': remoteController, 'CloseFragrance': remoteController}


def chat(messages):
    result = client.chat.completions.create(messages=messages, model="test", tools=tools)
    return result


def retain_one_if_same(lst):
    return list(set(lst))[0] if len(set(lst)) == 1 else lst[0]


messages = []
while True:
    prompt = input("请输入：")
    # if prompt == "clear":
    #     messages = []
    #     continue
    messages = []
    messages.append({"role": "user", "content": prompt})
    result = chat(messages)
    # print(result)

    if result.choices[0].message.tool_calls is not None:
        messages.append(result.choices[0].message)
        tool_result = []
        for item in result.choices[0].message.tool_calls:
            tool_call = item.function
            print(tool_call)
            name, arguments = tool_call.name, json.loads(tool_call.arguments)
            try:
                tool_result.append(tool_map[name](**arguments))
            except:
                tool_result.append("指令识别错误")
        messages.append({"role": "tool", "content": retain_one_if_same(tool_result)})
        # print(messages)
        result = client.chat.completions.create(messages=messages, model="test", tools=tools)
        print(result.choices[0].message.content)
        messages.append({"role": "assistant", "content": result.choices[0].message.content})
        print(messages)
    else:
        if "Action Input" in result.choices[0].message.content:
            msg_error = "很抱歉，我无法理解您的意思。"
            print(msg_error)
            messages.append({"role": "assistant", "content": msg_error})
        else:
            print(result.choices[0].message.content)
            messages.append({"role": "assistant", "content": result.choices[0].message.content})
            print(messages)
