export type Store = {id:string; name:string; kind:'retail'|'local'; city:string; description:string; status?:string};
export type Product = {id:string; store_id:string; name:string; category:string; price:number; stock:number; sizes:string[]; color:string; image:string; description:string; stores:Store};
export const stores:Store[]=[
{id:'studio',name:'Studio North',kind:'retail',city:'Lusaka',description:'Contemporary essentials for everyday dressing.'},
{id:'edit',name:'The Local Edit',kind:'local',city:'Lusaka',description:'Independent style, curated with care.'},
{id:'copper',name:'Copper Atelier',kind:'local',city:'Kitwe',description:'Accessories inspired by craft and modern living.'},
{id:'form',name:'Form & Field',kind:'retail',city:'Ndola',description:'Modern wardrobe staples for every season.'}];
const make=(id:string,store:number,name:string,category:string,price:number,stock:number,sizes:string[],color:string,image:string,description:string):Product=>({id,store_id:stores[store].id,name,category,price,stock,sizes,color,image,description,stores:stores[store]});
export const demoProducts=[
make('p1',0,'The city blazer','Women',480,12,['S','M','L'],'Sand','/products/blazer.svg','A clean, relaxed silhouette for workdays and evenings.'),
make('p2',1,'After hours dress','Women',320,9,['S','M','L'],'Merlot','/products/dress.svg','A fluid midi dress with a timeless evening silhouette.'),
make('p3',3,'Everyday runner','Shoes',550,15,['36','37','38','39','40','41','42'],'Ivory','/products/sneaker.svg','Minimal sneakers for an easy everyday look.'),
make('p4',2,'Woven carryall','Accessories',240,7,['One size'],'Honey','/products/bag.svg','A textured carryall for your daily essentials.'),
make('p5',3,'Weekend Oxford','Men',290,11,['S','M','L','XL'],'Blue','/products/shirt.svg','A versatile button-up for relaxed and smart occasions.'),
make('p6',1,'Wide leg denim','Women',360,8,['26','28','30','32'],'Indigo','/products/jeans.svg','High-rise denim with a comfortable wide leg.'),
make('p7',2,'Golden hour hoops','Accessories',110,17,['One size'],'Gold','/products/earrings.svg','Sculptural hoops with a warm polished finish.'),
make('p8',0,'Cloud knit','Men',260,10,['S','M','L','XL'],'Oat','/products/knit.svg','A soft neutral knit for cooler evenings.')];
export const money=(n:number)=>`K${Number(n).toLocaleString('en-ZM',{minimumFractionDigits:2,maximumFractionDigits:2})}`;
