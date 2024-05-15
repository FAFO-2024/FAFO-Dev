Config = {}
Config.Framework = 'newqb' -- esx, oldesx, qb, newqb, autodetect
Config.SQL = "oxmysql" -- oxmysql, ghmattimysql, mysql-async
Config.InteractionHandler = 'qb_target' -- drawtext, ox_target, qb_target, qb_textui, esx_textui
Config.MenuKey = 38
Config.JobStart = {
    coords = vector4(722.39886474609, -976.83581542969, 23.131553649902, 179.46690368652),
    npc = `a_f_m_downtown_01`,
}
Config.EnableRoutingBucket = false -- if true players cant see each other while working
Config.Blip = {
    name = 'Tailor Job',
    coords = vector3(717.54351806641, -976.58996582031, 24.905536651611),
    show = true, -- if you want to disable the blip, set this to false
    sprite = 79, 
    color  = 42,
    scale = 0.8,
}

Config.CarSpawn = {
    coords = vector4(710.48480224609, -987.78869628906, 24.111042022705, 282.69766235352),
    model = "speedo",
}

Config.upgradeItems = {
     {
        name= "iron",
        label= "Iron",
        image= "iron.png",
        price= 5,
      },
      {
        name= "rope_reel",
        label= "Rope Reel",
        image= "rope_reel.png",
        price= 5,
      },
      {
        name= "metal_bobbin",
        label= "Metal Bobbin",
        image= "metal_bobbin.png",
        price= 5,
      },
      {
        name= "thin_needle",
        label= "Thin Needle",
        image= "thin_needle.png",
        price= 5,
      },
      {
        name= "steel_bobbin",
        label= "Steel Bobbin",
        image= "steel_bobbin.png",
        price= 5,
      },
      {
        name= "knitting_wheel",
        label= "Knitting Wheel",
        image= "knitting_wheel.png",
        price= 5,
      },
}

Config.MarketItems = {
        {
        name = 'cotton',
        label = 'Cotton',
        image = 'cotton.png',
        price = 5,
      },
      {
        name= 'wool',
        label= 'Wool Yarn',
        image= 'wool.png',
        price= 5,
      },
      {
        name= 'acrylic',
        label= 'Acrylic',
        image= 'acrylic.png',
        price= 5,
      },
      {
        name= 'polyester',
        label= 'Polyester',
        image= 'polyester.png',
        price=5,
      },
      {
        name= 'cowhide',
        label= 'Cowhide',
        image= 'cowhide.png',
        price= 5,
      },
  
      {
        name= 'fiber',
        label= 'Acetata Fiber',
        image= 'fiber.png',
        price= 5,
      },    
      {
        name='cashmere',
        label= 'Cashmere',
        image= 'cashmere.png',
        price= 5,
      },   
      {
        name='spandex',
        label= 'Spandex',
        image= 'spandex.png',
        price= 5,
      },  
      {
        name='lyocell',
        label= 'Lyocell',
        image= 'lyocell.png',
        price= 5,
      },  
      {
        name='silver',
        label= 'Silver',
        image= 'silver.png',
        price= 5,
      },  
      {
        name= 'paint',
        label= 'Gold Paint',
        image= 'paint.png',
        price= 5,
      },             
      {
        name='metal',
        label= 'Metal',
        image= 'metal.png',
        price= 5,
      }, 
      {
        name= 'jute',
        label= 'Jute',
        image= 'jute.png',
        price= 5,
      },
      {
        name= 'cupro',
        label= 'Cupro',
        image= 'cupro.png',
        price= 5,
      },             
      {
        name= 'linen',
        label= 'Linen',
        image= 'linen.png',
        price= 5,
      }, 
      {
        name= 'nubuck',
        label= 'Nubuck',
        image= 'nubuck.png',
        price= 5,
      }, 
      {
        name= 'hemp',
        label= 'Hemp',
        image= 'hemp.png',
        price= 5,
      },   
      {
        name= 'quality_silk',
        label= 'Quality Silk',
        image= 'quality_silk.png',
        price= 5,
      },  
}
Config.WorkerSalaryTime = 30 -- minutes
Config.Workers = {
  {
        name= 'Agnes',
        proffesion_label= 'Binco Profession',
        salary= 2000,
        image= 'agnes_pp.png',
        type = 'binco',
        hash= 'a_f_m_eastsa_01',
        level = 10,
        perk = 0,
      },
      {
        name='Elizabeth',
        proffesion_label= 'Binco+ Profession',
        salary= 2500,
        image= 'elizabeth_pp.png',
        type= 'binco',
        hash= 'cs_janet',
        level = 15,
        perk = 20,
      },
      {
        name= 'Constance',
        proffesion_label= 'Binco++ Profession',
        salary= 3000,
        image= 'constance_pp.png',
        type= 'binco',
        hash= 'a_f_m_eastsa_02',
        level = 20,
        perk= 30,

      },
      {
        name= 'Mathilda',
        proffesion_label= 'Suburban Profession',
        salary= 3500,
        image= 'mathilda_pp.png',
        type= 'suburban',
        hash= 'a_f_y_eastsa_02',
        level= 22,
        perk= 0,

      },
      {
        name= 'Agatha',
        proffesion_label= 'Suburban+ Profession',
        salary= 3500,
        image= 'agatha_pp.png',
        type='suburban',
        hash= 'ig_kerrymcintosh',
        level = 34,
        perk= 20,

      },
      {
        name= 'Edith',
        proffesion_label= 'Suburban++ Profession',
        salary= 4000,
        image= 'edith_pp.png',
        type= 'suburban',
        hash= 'a_f_m_ktown_02',
        level= 46,
        perk= 30,

      },
   
      {
        name= 'Isabella',
        proffesion_label= 'Ponsonbys Proffesion',
        salary= 4000,
        image= 'isabella_pp.png',
        type='ponsonbys',
        hash= 'a_f_o_salton_01',
        level= 50,
        perk= 0,

      },      
      {
        name= 'Florence',
        proffesion_label= 'Ponsonbys+ Proffesion',
        salary= 4500,
        image= 'florence_pp.png',
        type= 'ponsonbys',
        hash= 'u_f_y_mistress',
        level= 62,
        perk= 20,

      },  
      {
        name= 'Ethel',
        proffesion_label= 'Ponsonbys++ Proffesion',
        salary= 4500,
        image= 'ethel_pp.png',
        type='ponsonbys',
        hash= 'u_f_o_moviestar',
        level= 70,
        perk= 30,

      },    
}

Config.outfits={
      ["suburban"]= {
        {
          name = "suburban_tshirt",
          label = "Suburban Tshirt",
          processTime= 300,
          businessLevel= 22 ,
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 10,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 5,
            },
            {
              name= "fiber",
              label= "Acetate Fiber",
              amount= 5,
            },
        },
        },
        {
          name= "suburban_bralet",
          label= "Suburban Bralet",
          businessLevel= 40,
          processTime= 240,
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 8,
            },
            {
              name="wool",
              label= "Wool Yarn",
              amount= 6,
            },
            {
              name= "acrylic",
              label= "Acrylic",
              amount= 5,
            },
        },
        },
        {
          name= "suburban_sweatshirt",
          label= "Suburban Sweatshirt",
          processTime= 240,
          businessLevel= 25,
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 10,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 5,
            },
            {
              name= "cashmere",
              label= "Cashmere",
              amount= 5,
            },
        },
        },
        {
          name= "suburban_short",
          label= "Suburban Jean",
          processTime= 300,
          businessLevel= 37,
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 8,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 6,
            },
            {
              name= "jute",
              label= "Jute",
              amount= 10,
            },
        },
        },
        {
          name= "suburban_jogger",
          label= "Suburban Jogger",
          processTime= 720,
          businessLevel= 28,
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 10,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 5,
            },
            {
              name = "spandex",
              label= "Spandex",
              amount= 5,
            },
            {
              name= "lyocell",
              label= "Lyocell",
              amount= 3,
            },
            },
        },
        {
          name= "suburban_dress",
          label= "Suburban Dress",
          processTime= 480,
          businessLevel= 46,
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 15,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 9,
            },
            {
              name= "acrylic",
              label= "Acrylic",
              amount= 10,
            },
        },
        },
        {
          name= "suburban_shirt",
          label= "Suburban Shirt",
          processTime= 360,
          businessLevel= 31,  
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 10,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 5,
            },
            {
              name= "polyester",
              label= "Polyester",
              amount= 2,
            },
            {
              name= "acrylic",
              label= "Acrylic",
              amount= 2,
            },
        },
        },
        {
          name= "suburban_chain",
          label= "Chain",
          processTime= 300,
          businessLevel= 34,  
          requiredItems= {
            {
              name= "silver",
              label= "Silver",
              amount= 10,
            },
            {
              name= "paint",
              label= "Gold Paint",
              amount= 5,
            },
            {
              name= "metal",
              label= "Metal",
              amount= 3,
            },
        },
        },
        {
          name= "suburban_skirt",
          label= "Skirt",
          processTime= 360,
          businessLevel= 37,  
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 10,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 5,
            },
            {
              name= "polyester",
              label= "Polyester",
              amount= 4,
            },
            {
              name= "spandex",
              label= "Spandex",
              amount= 2,
            },
        },
        },
    },
      ["ponsonbys"]= {
        {
          name= "ponsonbys_shirt",
          label= "Grey Shirt",
          processTime= 480,
          businessLevel= 49,
          requiredItems= {
            {
                label= "Cotton",
                name="cotton",
              amount= 10,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 8,
            },
            {
              name= "cupro",
              label= "Cupro",
              amount= 4,
            },
            {
              name= "polyester",
              label= "Polyester",
              amount= 5,
            },
        },
        },
        {
          name= "ponsonbys_suit",
          label= "Full Suit",
          processTime= 720,
          businessLevel= 73,
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 20,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 15,
            },
            {
              name="hemp",
              label= "Hemp",
              amount= 8,
            },
            {
              name= "quality_silk",
              label= "Quality Silk",
              amount=8,
            },
        },
        },
        {
          name= "ponsonbys_jacket",
          label= "Suit Jacket",
          processTime= 600,
          businessLevel= 53,
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 20,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 15,
            },
            {
              name= "hemp",
              label= "Hemp",
              amount= 8,
            },
            },
        },
        {
          name= "ponsonbys_chino",
          label= "Chino",
          processTime= 600,
          businessLevel= 57,
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 15,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 12,
            },
            {
              name= "cashmere",
              label= "Cashmere",
              amount= 8,
            },
        },
        },
        {
          name= "ponsonbys_waistcoats",
          label= "Waistcoats",
          processTime= 480,
          businessLevel= 61,
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 10,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 8,
            },
            {
              name= "linen",
              label= "Linen",
              amount= 12,
            },
        },
        },
        {
          name= "ponsonbys_tie",
          label= "Tie",
          processTime= 240,
          businessLevel= 65,
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 5,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 3,
            },
            {
              name= "linen",
              label= "Linen",
              amount= 4,
            },
        },
        },

        {
          name= "ponsonbys_belt",
          label= "Classy Belt",
          processTime= 360,
          businessLevel= 69,
          requiredItems= {
            {
              name= "nubuck",
              label= "Nubuck",
              amount= 10,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 4,
            },
        },
        },
        },
      ["binco"]= {
        {
          name= "binco_basic_blazer",
          label= "Basic Blazer",
          businessLevel=16,
          processTime= 600,
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 8,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 4,
            },
            {
              name= "acrylic",
              label= "Acrylic",
              amount= 2,
            },
            {
              name= "polyester",
              label= "Polyester",
              amount= 5,
            },
        },
        },
        {
          name= "binco_basic_tshirt",
          businessLevel= 1,
          label= "Basic Tshirt",
          processTime= 40,
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 10,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 5,
            },
        },
        },
        {
          name= "binco_basic_blouse",
          businessLevel= 12,
          label= "Basic Blouse",
          processTime= 240,
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 8,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 4,
            },
        },
        },
        {
          name= "binco_basic_sweatshirt",
          businessLevel =     3,
          label= "Basic Sweatshirt",
          processTime= 240,
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 12,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 7,
            },
        },
        },
        {
          name= "binco_basic_bralet",
          businessLevel= 14,
          label= "Basic Bralet",
          processTime= 240,
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 8,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 4,
            },
            {
              name= "acrylic",
              label= "Acrylic",
              amount= 2,
            },
        },
        },
        {
          name= "binco_basic_jean",
          label= "Basic Jean",
          businessLevel= 5,
          processTime= 360,
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 14,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 8,
            },
        },
        },
        {
          name= "binco_basic_shirt",
          label= "Basic Shirt",
          businessLevel= 7,
          processTime= 240,
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 10,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 8,
            },
        },
        },
        {
          name= "binco_basic_jumpsuit",
          label= "Basic Jumpsuit",
          processTime= 720,
          businessLevel= 18,
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 8,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 4,
            },
            {
              name= "acrylic",
              label= "Acrylic",
              amount= 6,
            },
            {
              name= "polyester",
              label= "Polyester",
              amount= 3,
            },
        },
        },
        {
          name= "binco_basic_singlet",
          label= "Basic Singlet",
          processTime= 240,
          businessLevel= 9,
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 5,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 3,
            },
        },
        },
        {
          name= "binco_basic_short",
          label= "Basic Short",
          processTime= 240,
          businessLevel= 20,
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 8,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 4,
            },
            {
              name= "polyester",
              label= "Polyester",
              amount= 4,
            },
        },
        },
        {
          name= "binco_basic_vest",
          label= "Basic Vest",
          businessLevel= 10,
          processTime= 600,
          requiredItems= {
            {
              name= "cotton",
              label= "Cotton",
              amount= 5,
            },
            {
              name= "wool",
              label= "Wool Yarn",
              amount= 43,
            },
            {
              name= "cowhide",
              label= "Cowhide",
              amount= 1,
            },
        },
        },
    },
}

Config.ShipOrder = {
    ["binco"] = {
        vector3(83.260772705078, -1389.0927734375, 29.417747497559),
        vector3(418.05206298828, -809.24572753906, 29.361982345581),
        vector3(-816.00634765625, -1078.3924560547, 11.132555961609),
        vector3(-3.5542924404144, 6515.8696289063, 31.483106613159),
        vector3(1686.8642578125, 4818.5893554688, 41.992794036865),
        vector3(1196.6787109375, 2701.8308105469, 38.156955718994),
        vector3(-1094.4910888672, 2706.5456542969, 19.064767837524)
    },
    ["ponsonbys"] = {
        vector3(-717.12512207031, -158.41526794434, 36.988182067871),
        vector3(-153.70567321777, -304.35623168945, 38.850429534912),
        vector3(-1455.1966552734, -229.82754516602, 49.258041381836),
        

    },
    ["suburban"] = {
        vector3(125.89737701416, -208.14096069336, 54.574993133545),
        vector3(619.14172363281, 2748.3212890625, 42.08810043335),
        vector3(-1202.1365966797, -780.42980957031, 17.333404541016),
        vector3(-3166.0869140625, 1058.1143798828, 20.858366012573)
    },
}

Config.Orders = {
   ["binco"] = {
    {
        id = 1,
        label = "Basic Tshirt",
        name = "binco_basic_tshirt",
        offer = 2000,
        amount = 25,
    },
    {
        id = 2,
        label = "Basic Blouse",
        name = "binco_basic_blouse",
        offer = 5000,
        amount = 45,
    },
    {
        id = 3,
        label = "Basic Sweatshirt",
        name = "binco_basic_sweatshirt",
        offer = 3500,
        amount = 15,
    },    
    {
        id = 4,
        label = "Basic Bralet",
        name = "binco_basic_bralet",
        offer = 5000,
        amount = 35,
    },
    {
        id = 5,
        label = "Basic Jean",
        name = "binco_basic_jean",
        offer = 3000,
        amount = 20,
    },        
    {
        id = 6,
        label = "Basic Blazer",
        name = "binco_basic_blazer",
        offer = 6500,
        amount = 15,
    },
    {
        id = 7,
        label = "Basic Shirt",
        name = "binco_basic_shirt",
        offer = 4500,
        amount = 30,
    },  
    {
        id = 8,
        label = "Basic Jumpsuit",
        name = "binco_basic_jumpsuit",
        offer = 6000,
        amount = 25,
    }, 
    {
        id = 9,
        label = "Basic Singlet",
        name = "binco_basic_singlet",
        offer = 4000,
        amount = 40,
    }, 
    {
        id = 10,
        label = "Basic Short",
        name = "binco_basic_short",
        offer = 7000,
        amount = 45,
    },    
    {
        id = 11,
        label = "Basic Vest",
        name = "binco_basic_vest",
        offer = 4500,
        amount = 15,
    },               
   },
   ["suburban"] = {
    {
        id = 12,
        label = "Sport Tshirt",
        name = "suburban_tshirt",
        offer = 3500,
        amount = 15,
    },
    {
        id = 13,
        label = "Bralet",
        name = "suburban_bralet",
        offer = 7500,
        amount = 45,
    },
    {
        id = 14,
        label = "Urban Sweatshirt",
        name = "suburban_sweatshirt",
        offer = 4500,
        amount = 20,
    },
    {
        id = 15,
        label = "Jean Short",
        name = "suburban_short",
        offer = 7500,
        amount = 30,
    },
    {
        id = 16,
        label = "Jogger",
        name = "suburban_jogger",
        offer = 4000,
        amount = 10,
    },
    {
        id = 17,
        label = "Red Dress",
        name = "suburban_dress",
        offer = 8000,
        amount = 35,
    }, 
    {
        id = 18,
        label = "Summer Shirt",
        name = "suburban_shirt",
        offer = 5000,
        amount = 25,
    },           
    {
        id = 19,
        label = "Chain",
        name = "suburban_chain",
        offer = 5000,
        amount = 25,
    },  
    {
        id = 20,
        label = "Skirt",
        name = "suburban_skirt",
        offer = 6500,
        amount = 30,
    },      
    
   },
   ["ponsonbys"] = {
        {
            id = 21,
            label = "Grey Shirt",
            name = "ponsonbys_shirt",
            offer = 5000,
            amount = 20,
        },    
        {
            id = 22,
            label = "Full Suit",
            name = "ponsonbys_suit",
            offer = 9500,
            amount = 15,
        },            
        {
            id = 23,
            label = "Suit Jacket",
            name = "ponsonbys_jacket",
            offer = 9500,
            amount = 15,
        }, 
        {
            id = 24,
            label = "Chino",
            name = "ponsonbys_chino",
            offer = 6000,
            amount = 20,
        }, 
        {
            id = 25,
            label = "Waistcoats",
            name = "ponsonbys_waistcoats",
            offer = 6000,
            amount = 15,
        },                           
        {
            id = 26,
            label = "Tie",
            name = "ponsonbys_tie",
            offer = 6500,
            amount = 35,
        }, 
        {
            id = 27,
            label = "Classy Belt",
            name = "ponsonbys_belt",
            offer = 6500,
            amount = 25,
        },               
   }, 
}

Config.Inventory = {
    coords = vector3(704.86700439453, -961.96838378906, 30.395315170288),
    materials = {
        "arcylic",
        "cashmere",
        "cotton",
        "cupro",
        "fiber",
        "hemp",
        "jute",
        "rope_reel",
        "linen",
        "thin_needle",
        "metal_bobbin",
        "knitting_wheel",
        "steel_bobbin",
        "lyocell",
        "metal",
        "nubuck",
        "paint",
        "polyester",
        "iron",
        "quality_silk",
        "silver",
        "spandex",
        "wool",
    },
    outfits = {
        "binco_basic_blazer",
        "binco_basic_blouse",
        "binco_basic_bralet",
        "binco_basic_jean",
        "binco_basic_jumpsuit",
        "binco_basic_shirt",
        "binco_basic_short",
        "binco_basic_singlet",
        "binco_basic_sweatshirt",
        "binco_basic_tshirt",
        "binco_basic_vest",
        "ponsonbys_belt",
        "ponsonbys_chino",
        "ponsonbys_jacket",
        "ponsonbys_shirt",
        "ponsonbys_suit",
        "ponsonbys_suit",
        "ponsonbys_waistcoats",
        "suburban_chain",
        "suburban_dress",
        "suburban_jogger",
        "suburban_shirt",
        "suburban_short",
        "suburban_skirt",
        "suburban_sweatshirt",
        "suburban_tshirt",
        "suburban_bralet",
    },
    allowedItems = {
        "binco_basic_blazer",
        "binco_basic_blouse",
        "binco_basic_bralet",
        "binco_basic_jean",
        "binco_basic_jumpsuit",
        "binco_basic_shirt",
        "binco_basic_short",
        "binco_basic_singlet",
        "binco_basic_sweatshirt",
        "binco_basic_tshirt",
        "binco_basic_vest",
        "ponsonbys_belt",
        "ponsonbys_chino",
        "ponsonbys_jacket",
        "ponsonbys_shirt",
        "ponsonbys_suit",
        "ponsonbys_suit",
        "ponsonbys_waistcoats",
        "suburban_chain",
        "suburban_dress",
        "suburban_jogger",
        "suburban_shirt",
        "suburban_short",
        "suburban_skirt",
        "suburban_sweatshirt",
        "suburban_tshirt",
        "suburban_bralet",
        "arcylic",
        "cashmere",
        "cotton",
        "cupro",
        "fiber",
        "hemp",
        "jute",
        "rope_reel",
        "linen",
        "thin_needle",
        "metal_bobbin",
        "knitting_wheel",
        "steel_bobbin",
        "lyocell",
        "metal",
        "nubuck",
        "paint",
        "polyester",
        "iron",
        "quality_silk",
        "silver",
        "spandex",
        "wool",
    }
}

Config.UpgradeMachine = {
    ['2']={
        cost = 25000,
        requiredItems = {
          {
            name  = 'iron',
            label = 'Iron',
            amount =  1,
            image  = 'iron.png',
          },
          {
            name   = 'rope_reel',
            label  = 'Rope',
            amount =  1,
            image = 'rope.png',
          }
        },
        desc= {
          'Able to produce “ Suburban “ clothes.',
          'Faster production on “ Binco “ clothes.',
          'Able to put worker on it',
          'Less Production cost on Binco Clothes',
        },
      },
      ['3']= {
        cost=40000,
        requiredItems= {
          {
            name = 'metal_bobbin',
            label= 'Metal Bobbin',
            amount= 1,
            image='metal_bobbin.png',
          },
          {
            name= 'thin_needle',
            label= 'Thin Needle',
            amount= 1,
            image= 'thin_needle.png',
          }
        },
        desc= {
          'Able to produce “ Ponsonbys “ clothes.',
          'Faster production on “ Suburban “ clothes.',
          'Less production cost on Suburban clothes.',
        },
      },
      ['4']= {
        cost= 50000,
        requiredItems= {
          {
            name = 'steel_bobbin',
            label= 'Steel Bobbin',
            amount= 2,
            image='steel_bobbin.png',
          },
          {
            name= 'knitting_wheel',
            label= 'Knitting Wheel',
            image= 'knitting_wheel.png',
            amount= 2,
          }
        },
        desc= {
          'Faster production on “ Ponsonbys “ clothes.',
          'Less production cost on Ponsonbys clothes.',
        },
      },
}

Config.SewingMachines = {
    {

        coords = vector3(713.37164306641, -960.54467773438, 29.674718856812),
        npc_coords = vector3(713.94256591797, -961.5205078125, 30.395315170288),
    },
    {
        coords = vector3(716.02282714844, -960.58880615234, 29.599210739136),
        npc_coords = vector4(716.45690917969, -961.59588623047, 30.395317077637, 0.75246965885162),

    },
    {
        coords = vector3(718.42614746094, -960.66638183594, 29.565986633301),
        npc_coords = vector4(718.94250488281, -961.59094238281, 30.395347595215, 1.0905787944794),
    },
    {
        coords = vector3(715.77172851563, -962.98645019531, 29.64896774292),
        npc_coords = vector4(715.65020751953, -962.49249267578, 30.395315170288, 177.44332885742),
    },
    {
        coords = vector3(718.43225097656, -963.15069580078, 29.611867904663),
        npc_coords = vector4(718.42565917969, -962.49261474609, 30.395315170288, 189.61828613281),
    },
    {
        coords = vector3(714.28356933594, -967.47705078125, 29.442222595215),
        npc_coords = vector4(713.31457519531, -967.80279541016, 30.395313262939, 275.87121582031),
    },
    {
        coords = vector3(714.22918701172, -969.71295166016, 29.393354415894),
        npc_coords = vector4(713.32733154297, -969.76641845703, 30.395315170288, 269.33020019531)
    }, 
    {
        coords = vector3(714.22918701172, -971.96069335938, 29.383247375488),
        npc_coords = vector4(713.25598144531, -972.17858886719, 30.395347595215, 272.54229736328),
    }
}

Config.Laptop = {
    coords = vector3(707.34509277344, -966.99127197266, 30.412853240967),
}


Config.XP = {
}
CreateThread(function()
    for i = 1, 100 do
        table.insert(Config.XP, i * 1000)
    end
end)

Config.Notification = function(message, isServer, src) -- You can change here events for notifications
    if isServer then
        if Config.Framework == "esx" then
            TriggerClientEvent("esx:showNotification", src, message)
        else
            TriggerClientEvent('QBCore:Notify', src, message, 'primary', 2500)
        end
    else
        if Config.Framework == "esx" then
            TriggerEvent("esx:showNotification", message)
        else
            TriggerEvent('QBCore:Notify', message, 'primary', 2500)
        end
    end
end



Config.Vehiclekey          = true
Config.VehicleSystem       = "qb-vehiclekeys"       -- cd_garage / qs-vehiclekeys / wasabi-carlock / qb-vehiclekeys
Config.Removekeys          = true
Config.RemoveVehicleSystem = "qb-vehiclekeys"       -- cd_garage / qs-vehiclekeys / wasabi-carlock / qb-vehiclekeys

Config.GiveVehicleKey      = function(plate, model) -- you can change vehiclekeys export if you use another vehicle key system
    if Config.Vehiclekey then
        if Config.VehicleSystem == 'cd_garage' then
            TriggerEvent('cd_garage:AddKeys', exports['cd_garage']:GetPlate(vehicle))
        elseif Config.VehicleSystem == 'qs-vehiclekeys' then
            exports['qs-vehiclekeys']:GiveKeys(plate, model)
        elseif Config.VehicleSystem == 'wasabi-carlock' then
            exports.wasabi_carlock:GiveKey(plate)
        elseif Config.VehicleSystem == 'qb-vehiclekeys' then
            TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
        end
    end
end
Config.RemoveVehiclekey    = function(plate, model)
    if Config.Removekeys then
        if Config.RemoveVehicleSystem == 'cd_garage' then
            TriggerServerEvent('cd_garage:RemovePersistentVehicles', exports['cd_garage']:GetPlate(vehicle))
        elseif Config.RemoveVehicleSystem == 'qs-vehiclekeys' then
            exports['qs-vehiclekeys']:RemoveKeys(plate, model)
        elseif Config.RemoveVehicleSystem == 'wasabi-carlock' then
            exports.wasabi_carlock:RemoveKey(plate)
        elseif Config.RemoveVehicleSystem == 'qb-vehiclekeys' then
            TriggerServerEvent('qb-vehiclekeys:client:RemoveKeys', plate)
        end
    end
end


-- Config.UseLegacyFuel  = GetResourceState("LegacyFuel") ~= "missing" -- true enabled -- false disabled
Config.FuelSystem = "cdn-fuel"                      -- LegacyFuel / x-fuel

Config.SetVehicleFuel = function(vehicle, fuel_level) -- you can change LegacyFuel export if you use another fuel system
    if Config.FuelSystem == 'cdn-fuel' then
        return exports["cdn-fuel"]:SetFuel(vehicle, fuel_level)
    elseif Config.FuelSystem == 'x-fuel' then
        return exports["x-fuel"]:SetFuel(vehicle, fuel_level)
    else
        return SetVehicleFuelLevel(vehicle, fuel_level + 0.0)
    end
end