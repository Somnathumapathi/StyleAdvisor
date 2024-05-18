const express = require('express')
const app = express()
const PORT = 3000
const { createClient } = require('@supabase/supabase-js');

const supabase = createClient('https://acwqoculwoixjlhufwys.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFjd3FvY3Vsd29peGpsaHVmd3lzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTYwNTE5NTEsImV4cCI6MjAzMTYyNzk1MX0.z05I_oNjNjsfqsF682q7qvR2Q9rgJOtMI4q-NHoApMk')
app.use(express.json());

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Connected at port ${PORT}`)
})

app.post('/addHc', async (req, res) => {
try {
const { haircutName, gen, shape, description, imgUrl } = req.body
const {data, error} = await supabase.from('Haircuts').insert([
    {
        haircutName: haircutName,
        gen: gen,
        shape: shape,
        description: description,
        imgUrl: imgUrl
    }
   

])
if(error) throw error
return res.status(200).json({'message': 'Success'})

} catch (e) {    
    return res.status(500).json({error: e.message})
}
})

app.get('/getRecommendations', async (req,res) => {
    try{
        console.log(req.params.gen)
const {data, error} = await supabase.from('Haircuts').select()
// .match({'gen': req.params.gen, 'shape': req.params.shape})
.eq('gen', req.query.gen).eq('shape', req.query.shape)
if(error) throw error
if(!data) return res.status(400).json({'msg':'No data'})
console.log(data)
return res.status(200).json(data)
    } catch (e) {
        return res.status(500).json({error: e.message})
    }
})

