mv = {}
return {
{Meta = function(meta) -- Right from the documentation
for k, v in pairs(meta) do
   if type(v) == 'table' and v.t == 'MetaInlines' then
     mv[k] = {table.unpack(v)}
   elseif type(v) == 'string' then
     mv[k] = v
   end   
end
end},
{Math = function(elem)
    if mv['tm2lm'] then -- a meta var that you define to turn this on
        if elem.mathtype == "DisplayMath" then
            doc = pandoc.read('$ ' .. elem.text .. ' $', 'typst')
               -- I think this ^^ is stupid but I don’t know another way
               -- to parse the source as Typst math within the LaTeX doc
        else
            doc = pandoc.read('$' .. elem.text .. '$', 'typst')
        end
        return doc.blocks[1].content
    end
end},
}
