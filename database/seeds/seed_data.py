"""Seed data script for CraftMitra AI backend.

Populates initial authentic Indian master artisans, craft catalog items,
and users matching the frontend mobile marketplace.
"""

import os
import sys

# Add backend directory to sys.path so app modules can be imported
backend_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..', 'backend', 'craftmitra_api'))
if backend_dir not in sys.path:
    sys.path.insert(0, backend_dir)

from app.core.security import hash_password
from app.database.base import Base
from app.database.database import SessionLocal, engine
from app.models.artisan import Artisan
from app.models.artisan_story import ArtisanStory
from app.models.product import Product
from app.models.product_image import ProductImage
from app.models.user import User


def seed_database():
    print('Creating database tables if not exist...')
    Base.metadata.create_all(bind=engine)

    db = SessionLocal()
    try:
        # Check if already seeded
        if db.query(User).filter(User.email == 'ramkishan.clay@craftmitra.in').first():
            print('Database already seeded. Skipping.')
            return

        print('Seeding users and master artisans...')

        # 1. Customer User
        customer_user = User(
            id='user-cust-001',
            name='Aarav Sharma',
            email='aarav.sharma@example.com',
            phone='+91 98765 43210',
            password_hash=hash_password('Aarav@123'),
            role='customer',
        )
        db.add(customer_user)

        # 2. Master Artisan: Ramkishan Prajapati
        artisan_user_1 = User(
            id='user-art-001',
            name='Pandit Ramkishan Prajapati',
            email='ramkishan.clay@craftmitra.in',
            phone='+91 94140 12345',
            password_hash=hash_password('Artisan@123'),
            role='artisan',
        )
        db.add(artisan_user_1)
        db.flush()

        artisan_1 = Artisan(
            id='art-001',
            user_id=artisan_user_1.id,
            business_name='Molela Terracotta Studio',
            craft_type='Molela Terracotta Art',
            village='Molela',
            state='Rajasthan',
            location='Molela, Rajsamand, Rajasthan',
            bio='4th generation terracotta sculptor specializing in sun-baked votive tablets using indigenous Banas river clay and organic stone dyes.',
            years_of_experience=34,
            rating=4.9,
            review_count=284,
            is_verified=True,
            avatar_url='https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80',
            cover_image_url='https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?auto=format&fit=crop&w=800&q=80',
            awards='National Craft Master 2018, Shilp Guru Nominee',
            bank_account_verified=True,
            upi_id='ramkishan.clay@sbi',
        )
        db.add(artisan_1)

        # 3. Master Artisan: Shanti Devi Bunker
        artisan_user_2 = User(
            id='user-art-002',
            name='Shanti Devi Bunker',
            email='shanti.chanderi@craftmitra.in',
            phone='+91 98260 54321',
            password_hash=hash_password('Artisan@123'),
            role='artisan',
        )
        db.add(artisan_user_2)
        db.flush()

        artisan_2 = Artisan(
            id='art-002',
            user_id=artisan_user_2.id,
            business_name='Pranpur Handloom Weavers',
            craft_type='Chanderi Zari Weaving',
            village='Pranpur',
            state='Madhya Pradesh',
            location='Pranpur, Chanderi, Madhya Pradesh',
            bio='Master weaver preserving 700-year-old pit-loom silk weaving techniques taught by her grandmother. Empowers 28 rural women weavers.',
            years_of_experience=26,
            rating=5.0,
            review_count=312,
            is_verified=True,
            avatar_url='https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80',
            cover_image_url='https://images.unsplash.com/photo-1610030469983-98e550d6193c?auto=format&fit=crop&w=800&q=80',
            awards='Sant Kabir State Award, Craft Heritage Fellow',
            bank_account_verified=True,
            upi_id='shanti.devi@pnb',
        )
        db.add(artisan_2)

        # 4. Master Artisan: Geeta Jha
        artisan_user_3 = User(
            id='user-art-003',
            name='Geeta Jha',
            email='geeta.mithila@craftmitra.in',
            phone='+91 94310 98765',
            password_hash=hash_password('Artisan@123'),
            role='artisan',
        )
        db.add(artisan_user_3)
        db.flush()

        artisan_3 = Artisan(
            id='art-003',
            user_id=artisan_user_3.id,
            business_name='Mithila Folk Heritage',
            craft_type='Mithila & Madhubani Art',
            village='Ranti',
            state='Bihar',
            location='Ranti, Madhubani, Bihar',
            bio='Creates natural pigment Mithila paintings depicting nature, rituals, and folklore using bamboo twigs on cowdung-treated paper.',
            years_of_experience=19,
            rating=4.8,
            review_count=198,
            is_verified=True,
            avatar_url='https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=400&q=80',
            cover_image_url='https://images.unsplash.com/photo-1582560475093-ba66accbc424?auto=format&fit=crop&w=800&q=80',
            awards='State Handicraft Excellence 2021',
            bank_account_verified=True,
            upi_id='geeta.jha@barodabank',
        )
        db.add(artisan_3)

        # 5. Master Artisan: Budhram Baghel
        artisan_user_4 = User(
            id='user-art-004',
            name='Budhram Baghel',
            email='budhram.bastar@craftmitra.in',
            phone='+91 94250 67890',
            password_hash=hash_password('Artisan@123'),
            role='artisan',
        )
        db.add(artisan_user_4)
        db.flush()

        artisan_4 = Artisan(
            id='art-004',
            user_id=artisan_user_4.id,
            business_name='Bastar Dhokra Bell Metal Crafts',
            craft_type='Bastar Dhokra Lost-Wax Casting',
            village='Kondagaon',
            state='Chhattisgarh',
            location='Kondagaon, Bastar, Chhattisgarh',
            bio='Practices ancient 4,000-year-old Harappan lost-wax bell metal casting using beeswax, riverbed clay, and recycled brass scraps.',
            years_of_experience=31,
            rating=4.9,
            review_count=174,
            is_verified=True,
            avatar_url='https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=400&q=80',
            cover_image_url='https://images.unsplash.com/photo-1563245372-f21724e3856d?auto=format&fit=crop&w=800&q=80',
            awards='Tribal Artisan Honor 2019',
            bank_account_verified=True,
            upi_id='budhram.dhokra@ubi',
        )
        db.add(artisan_4)

        db.flush()

        # Seed Stories
        story_1 = ArtisanStory(
            artisan_id=artisan_1.id,
            title='Echoes of Molela River Clay',
            story='Centuries ago, a blind potter had a dream where Dharmaraja asked him to sculpt votive clay plaques using Banas river mud. In the morning, the potter’s vision returned. Since then, each generational plaque is sculpted without molds by the Kumhar community of Molela.',
            audio_url='https://craftmitra.in/audio/molela_clay_story.mp3',
            audio_duration_seconds=165,
        )
        db.add(story_1)

        print('Seeding authentic craft products...')

        # Product 1: Molela Terracotta Wall Plaque
        p1 = Product(
            id='prod-001',
            artisan_id=artisan_1.id,
            name='Molela Sun God Terracotta Wall Plaque',
            category='Terracotta',
            material='Riverbed Clay, Natural Acacia Resin, Ochre Red Pigment',
            price=2450.0,
            original_price=3200.0,
            description='Hand-sculpted ritual terracotta wall tile depicting Surya Dev, crafted from fertile Banas river clay and dried under desert sun.',
            cultural_story='Molela hollow votive plaques have been crafted for over 300 years by the Kumhar community for tribal shrines in southern Rajasthan. Every line is hand-pinched with thumb and wooden knife without molds.',
            dimensions='30 x 22 x 6 cm',
            weight='2.1 kg',
            time_to_create_hours=28,
            is_verified_craft=True,
            is_sustainable=True,
            stock_quantity=4,
            fair_price_min=2200.0,
            fair_price_max=2800.0,
            artisan_share_percent=86.0,
        )
        db.add(p1)
        db.flush()

        db.add(ProductImage(product_id=p1.id, image_url='https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?auto=format&fit=crop&w=800&q=80', is_primary=True))
        db.add(ProductImage(product_id=p1.id, image_url='https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?auto=format&fit=crop&w=800&q=80', is_primary=False))

        # Product 2: Chanderi Silk Saree
        p2 = Product(
            id='prod-002',
            artisan_id=artisan_2.id,
            name='Pure Chanderi Silk Zari Saree in Ochre',
            category='Handloom',
            material='Pure Mulberry Silk, Fine Cotton Warp, Tested Gold Zari',
            price=7800.0,
            original_price=9500.0,
            description='Feather-light Chanderi silk saree with hand-woven tested zari bootis and traditional ashrafi borders woven on wooden pit-looms.',
            cultural_story='Chanderi weaving flourished under royal Scindia patronage. This saree took Shanti Devi and her daughter 18 days of rhythmic loom work, passing silk threads through comb teeth 1,200 times per meter.',
            dimensions='5.5 m + 80 cm blouse',
            weight='430 grams',
            time_to_create_hours=64,
            is_verified_craft=True,
            is_sustainable=True,
            stock_quantity=2,
            fair_price_min=7200.0,
            fair_price_max=8500.0,
            artisan_share_percent=88.0,
        )
        db.add(p2)
        db.flush()

        db.add(ProductImage(product_id=p2.id, image_url='https://images.unsplash.com/photo-1610030469983-98e550d6193c?auto=format&fit=crop&w=800&q=80', is_primary=True))

        # Product 3: Madhubani Tree of Life
        p3 = Product(
            id='prod-003',
            artisan_id=artisan_3.id,
            name='Madhubani Tree of Life Folk Painting',
            category='Madhubani Art',
            material='Handmade Khadi Paper, Natural Vegetable Inks, Soot Dye',
            price=3600.0,
            original_price=4500.0,
            description='Original hand-drawn Mithila artwork symbolizing fertility and eternity, made with bamboo reeds and soot ink on cowdung-treated paper.',
            cultural_story='In Mithila culture, women draw the sacred Kalpavriksha tree on home mud walls during weddings. Geeta prepares pigments from turmeric, bilva leaves, and flame-of-forest blossoms.',
            dimensions='42 x 30 cm',
            weight='150 grams',
            time_to_create_hours=22,
            is_verified_craft=True,
            is_sustainable=True,
            stock_quantity=6,
            fair_price_min=3200.0,
            fair_price_max=4000.0,
            artisan_share_percent=85.0,
        )
        db.add(p3)
        db.flush()

        db.add(ProductImage(product_id=p3.id, image_url='https://images.unsplash.com/photo-1582560475093-ba66accbc424?auto=format&fit=crop&w=800&q=80', is_primary=True))

        # Product 4: Bastar Dhokra Musician
        p4 = Product(
            id='prod-004',
            artisan_id=artisan_4.id,
            name='Bastar Dhokra Lost-Wax Horn Musician',
            category='Brass & Metal',
            material='Recycled Brass, Natural Beeswax, Termite Hill Mud',
            price=2900.0,
            original_price=3800.0,
            description='Single-cast brass figurine created using the rare ancient hollow lost-wax casting technique passed down by Bastar tribal elders.',
            cultural_story='Because the clay core mold is shattered to release the molten metal, no two Dhokra figures in the world can ever be identical. This musician captures traditional forest harvest festivals.',
            dimensions='22 x 10 x 8 cm',
            weight='1.4 kg',
            time_to_create_hours=36,
            is_verified_craft=True,
            is_sustainable=True,
            stock_quantity=3,
            fair_price_min=2600.0,
            fair_price_max=3400.0,
            artisan_share_percent=87.0,
        )
        db.add(p4)
        db.flush()

        db.add(ProductImage(product_id=p4.id, image_url='https://images.unsplash.com/photo-1563245372-f21724e3856d?auto=format&fit=crop&w=800&q=80', is_primary=True))

        # Product 5: Saharanpur Wood Box
        p5 = Product(
            id='prod-005',
            artisan_id=artisan_1.id,
            name='Saharanpur Hand-carved Sheesham Jali Box',
            category='Wood Carving',
            material='Aged Sheesham Wood, Brass Leaf Inlay, Natural Beeswax Polish',
            price=1850.0,
            original_price=2400.0,
            description='Intricately pierced floral fretwork box carved from reclaimed aged Indian Rosewood with brass inlay accents.',
            cultural_story='Saharanpur woodcraft traces its origins to Mughal architecture. Each perforation is individually chiseled with hand-forged gouges without machine laser stamping.',
            dimensions='20 x 14 x 9 cm',
            weight='750 grams',
            time_to_create_hours=16,
            is_verified_craft=True,
            is_sustainable=True,
            stock_quantity=7,
            fair_price_min=1650.0,
            fair_price_max=2100.0,
            artisan_share_percent=84.0,
        )
        db.add(p5)
        db.flush()

        db.add(ProductImage(product_id=p5.id, image_url='https://images.unsplash.com/photo-1532372576444-dda954194ad0?auto=format&fit=crop&w=800&q=80', is_primary=True))

        # Product 6: Golden Grass Basket
        p6 = Product(
            id='prod-006',
            artisan_id=artisan_2.id,
            name='Kendrapara Golden Grass Handwoven Basket',
            category='Eco & Fiber',
            material='Wild Kaincha Grass, Organic Beetroot Dye',
            price=1250.0,
            original_price=1600.0,
            description='Biodegradable natural golden grass (Kaincha) storage basket woven by coastal rural women with geometric dyed accents.',
            cultural_story='Kaincha grass grows wild in riparian wetlands. Artisans split the stems using teeth and fingers, then weave sturdy storage vessels that last over two decades.',
            dimensions='28 x 28 x 20 cm',
            weight='480 grams',
            time_to_create_hours=12,
            is_verified_craft=True,
            is_sustainable=True,
            stock_quantity=9,
            fair_price_min=1100.0,
            fair_price_max=1450.0,
            artisan_share_percent=90.0,
        )
        db.add(p6)
        db.flush()

        db.add(ProductImage(product_id=p6.id, image_url='https://images.unsplash.com/photo-1584992236310-6edddc08acff?auto=format&fit=crop&w=800&q=80', is_primary=True))

        db.commit()
        print('Database successfully seeded with authentic Indian craft heritage records!')

    except Exception as e:
        db.rollback()
        print(f'Error seeding database: {e}')
        raise
    finally:
        db.close()


if __name__ == '__main__':
    seed_database()
