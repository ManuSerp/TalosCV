#ifndef TIAGO_CONTROLLER_TTS_CLIENT_HPP
#define TIAGO_CONTROLLER_TTS_CLIENT_HPP

#include <vector>
#include <memory>
#include <thread>

#include <ros/ros.h>

#include <actionlib/client/simple_action_client.h>

#include <pal_interaction_msgs/TtsAction.h>
#include <pal_interaction_msgs/TtsActionGoal.h>

class TextToSpeechClient
{

public:
    TextToSpeechClient(const std::string &server_name)
        : _tts_server_name(server_name),
          _tts_client(std::make_shared<actionlib::SimpleActionClient<pal_interaction_msgs::TtsAction>>(server_name, true))
    {
    }

    virtual ~TextToSpeechClient()
    {
        for (auto &thr : _tts_call_thread)
            thr.join();
    }

    void text_to_speech(const std::string &text, const std::string &language = "en_GB")
    {
        auto tts_call_function = [=]()
        {
            ros::Duration timeout_sec(3.0);

            if (_tts_client->waitForServer(timeout_sec))
            {
                ROS_INFO_STREAM("[TTS client] Say:" << text);
                pal_interaction_msgs::TtsGoal action_goal;
                action_goal.rawtext.text = text;
                action_goal.rawtext.lang_id = language;
                _tts_client->sendGoal(action_goal);
            }
            else
            {
                ROS_WARN_STREAM("[TTS client] No connection to server " << _tts_server_name << " to say: " << text);
            }
        };

        _tts_call_thread.push_back(std::thread(tts_call_function));
    }

private:
    std::string _tts_server_name;
    std::shared_ptr<actionlib::SimpleActionClient<pal_interaction_msgs::TtsAction>> _tts_client;

    std::vector<std::thread> _tts_call_thread;
};

#endif // TIAGO_CONTROLLER_TTS_CLIENT_HPP
