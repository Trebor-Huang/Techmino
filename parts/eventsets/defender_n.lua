return{
    drop=30,lock=60,
    fall=10,
    mesDisp=function(P)
        setFont(55)
        mStr(P.modeData.wave,63,200)
        mStr(P.modeData.rpm,63,320)
        mText(TEXTOBJ.wave,63,260)
        mText(TEXTOBJ.rpm,63,380)
    end,
    task=function(P)
        while true do
            YIELD()
            if P.control then
                local D=P.modeData
                D.counter=D.counter+1
                local t=
                    D.wave<=60 and 360-D.wave*3 or
                    D.wave<=120 and 180-(D.wave-60)*2 or
                    D.wave<=180 and 120-(D.wave-120)or
                    60
                if D.counter>=t then
                    D.counter=0
                    for _=1,3 do
                        table.insert(P.atkBuffer,{line=generateLine(P.holeRND:random(10)),amount=1,countdown=2*t,cd0=2*t,time=0,sent=false,lv=1})
                    end
                    P.atkBufferSum=P.atkBufferSum+3
                    P.stat.recv=P.stat.recv+3
                    D.wave=D.wave+1
                    D.rpm=math.floor(108e3/t)*.1
                    if D.wave==60 then
                        P:_showText(text.great,0,-140,100,'appear',.6)
                        P.gameEnv.pushSpeed=2
                        P.dropDelay,P.gameEnv.drop=20,20
                    elseif D.wave==120 then
                        P:_showText(text.awesome,0,-140,100,'appear',.6)
                        P.gameEnv.pushSpeed=3
                        P.dropDelay,P.gameEnv.drop=10,10
                    elseif D.wave==180 then
                        P.dropDelay,P.gameEnv.drop=5,5
                        P:_showText(text.maxspeed,0,-140,100,'appear',.6)
                    end
                    P:shakeField(3)
                end
            end
        end
    end
}
