require! <[fs request]>

data = JSON.parse(fs.read-file-sync \starbucks.json .toString!)
chk = {}
fetch = (list) ->
  if list.length == 0 =>
    fs.write-file-sync \count.json, JSON.stringify(chk)
    console.log \done
    return
  item = list.splice(0,1)0
  if !item => 
    console.log item
    console.log list
    return
  #console.log item
  if !item.id => 
    console.log item
    setTimeout (->fetch list),0
    return
  request {
    url: "http://graph.facebook.com/#{item.id}"
    method: \GET
  }, (e,r,b) ->
    c = JSON.parse(b)
    console.log item.name, item.id, c.checkins
    chk[item.id] = c.checkins
    setTimeout (->fetch list), 0

fetch data.data
